require 'rubygems'
require 'mime/types'
require 'securerandom'

module FacePP
  class MultiPart
    def initialize
      @fields = []
      @files = []
      @boundary = [SecureRandom.random_bytes(15)].pack('m*').chop!
    end

    def add_field name, value
      @fields << [name, value]
    end

    def add_file name, filepath
      @files << [name, filepath]
    end

    def self.guess_mime filename
      res = MIME::Types.type_for(filename)
      res.empty? ? 'application/octet-stream' : res[0]
    end

    def has_file?
      not @files.empty?
    end

    def content_type
      "multipart/form-data; boundary=#{@boundary}"
    end

    def inspect
      res = StringIO.new
      append_boundary = lambda { res.write "--#{@boundary}\r\n" }
      @fields.each do |field|
        append_boundary[]
        res.write "Content-Disposition: form-data; name=\"#{field[0]}\"\r\n\r\n#{field[1]}\r\n"
      end
      @files.each do |file|
        append_boundary[]
        res.write "Content-Disposition: file; name=\"#{file[0]}\"; filename=\"#{file[1]}\"\r\n"
        res.write "Content-Type: #{self.class.guess_mime file[1]}\r\n"
        res.write "Content-Transfer-Encoding: binary\r\n\r\n"
        res.write File.open(file[1]).read
        res.write "\r\n"
      end
      res.write "--#{@boundary}--\r\n"
      res.rewind
      res.read
    end
  end
end
