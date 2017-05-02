module FacePP
  class Body < Client
    BASE_URL = 'https://api-cn.faceplusplus.com/humanbodypp'.freeze
    APIS = %w(/beta/detect /beta/segment).freeze
  end
end
