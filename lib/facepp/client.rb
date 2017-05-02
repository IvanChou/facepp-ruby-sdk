require 'rubygems'
require 'json'
require 'net/http'
require 'uri'

module FacePP
  class Client
    private_class_method :new

    class << self
      def inherited(kclass)
        kclass.public_class_method :new
      end

      def send_request(uri, args, form = nil)
        req = Net::HTTP::Post.new uri
        if form.has_file?
          req.set_content_type form.content_type
          req.body = form.inspect
          req['Content-Length'] = req.body.size
        else
          req.set_form_data args
        end

        Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
      end
    end

    def initialize(key, secret, options={})
      decode = options.fetch :decode, true
      base_url = self.class.const_get :BASE_URL

      self.class.const_get(:APIS).each do |api|
        m = self
        breadcrumbs = api.split('/')[1..-1]
        breadcrumbs[0..-2].each do |breadcrumb|
          unless m.instance_variable_defined? "@#{breadcrumb}"
            m.instance_variable_set "@#{breadcrumb}", Object.new
            m.singleton_class.class_eval do
              attr_reader breadcrumb
            end
          end
          m = m.instance_variable_get "@#{breadcrumb}"
        end

        m.define_singleton_method breadcrumbs[-1] do |**args|
          uri = URI(File.join base_url, api)
          params = {api_key: key, api_secret: secret}
          form = MultiPart.new
          image_file = args.delete(:image_file)
          args.each { |k, v| params[k] =  v.is_a?(Enumerable) ? v.to_a.join(',') : v }

          unless image_file.nil?
            form.add_file :image_file, image_file
            uri.query = URI::encode_www_form(params)
          end

          res = Client.send_request uri, params, form
          decode ? JSON.load(res.body) || {error_message: ''} : res
        end
      end
    end
  end
end
