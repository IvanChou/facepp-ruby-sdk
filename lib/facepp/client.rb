require 'rubygems'
require 'json'
require 'net/http'
require 'uri'

module FacePP
  class Client
    BASE_URL = 'https://api-cn.faceplusplus.com/facepp'.freeze
    APIS = %w(
      /v3/detect
      /v3/compare
      /v3/search
      /v3/faceset/create
      /v3/faceset/addface
      /v3/faceset/removeface
      /v3/faceset/update
      /v3/faceset/getdetail
      /v3/faceset/delete
      /v3/faceset/getfacesets
      /v3/face/analyze
      /v3/face/getdetail
      /v3/face/setuserid).freeze

    def initialize(key, secret, options={})
      decode = options.fetch :decode, true

      APIS.each do |api|
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

        m.define_singleton_method breadcrumbs[-1] do |*args|
          uri = URI(File.join BASE_URL, api)
          form = MultiPart.new
          fields = {api_key: key, api_secret: secret}

          (args[0] || {}).each do |k,v|
            if k.to_s == 'image_file'  # via POST
              form.add_file k, v
            else
              fields[k] = v.is_a?(Enumerable) ? v.to_a.join(',') : v
            end
          end
          req = Client.generate_request uri, fields, form
          res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }
          decode ? JSON.load(res.body) || {error_message: ''} : res
        end
      end
    end

    def self.generate_request(uri, args, form = nil)
      if form.has_file?
        uri.query = URI::encode_www_form(args)
        req = Net::HTTP::Post.new uri
        req.set_content_type form.content_type
        req.body = form.inspect
        req['Content-Length'] = req.body.size
      else
        req = Net::HTTP::Post.new uri
        req.set_form_data args
      end
      req
    end
  end
end
