module FacePP
  class Card < Client
    BASE_URL = 'https://api-cn.faceplusplus.com/cardpp'.freeze
    APIS = %w(/v1/ocridcard /v1/ocrdriverlicense /v1/ocrvehiclelicense).freeze
  end
end