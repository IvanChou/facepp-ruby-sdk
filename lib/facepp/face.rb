module FacePP
  class Face < Client
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
  end
end
