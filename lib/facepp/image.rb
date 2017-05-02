module FacePP
  class Image < Client
    BASE_URL = 'https://api-cn.faceplusplus.com/imagepp'.freeze
    APIS = %w(/beta/detectsceneandobject /beta/recognizetext).freeze
  end
end