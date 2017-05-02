# FacePlusPlus Ruby SDK

A Ruby interface to the FacePlusPlus API.

## Supported Ruby Versions

This sdk has been tested against the following Ruby versions:

- 2.0.0 and upper

## Installation

```bash
gem build facepp.gemspec
gem install *.gem
```

## Get Started

```ruby
require 'facepp'

# For hunman face detecting
# Doc: https://console.faceplusplus.com.cn/documents/4888373
api = FacePP::Face.new 'YOUR_API_KEY', 'YOUR_API_SECRET'
puts api.v3.detect image_file: '/tmp/0.jpg'

# For hunman body detecting
# Doc: https://console.faceplusplus.com.cn/documents/7774430
api = FacePP::Body.new 'YOUR_API_KEY', 'YOUR_API_SECRET'
puts api.beta.detect image_file: '/tmp/0.jpg'

# For (Chinese) ID Card detecting
# Doc: https://console.faceplusplus.com.cn/documents/5671702
api = FacePP::Card.new 'YOUR_API_KEY', 'YOUR_API_SECRET'
puts api.v1.ocridcard image_file: '/tmp/0.jpg'

# For image orc detecting
# Doc: https://console.faceplusplus.com.cn/documents/5671708
api = FacePP::Image.new 'YOUR_API_KEY', 'YOUR_API_SECRET'
puts api.beta.detectsceneandobject image_file: '/tmp/0.jpg'
```

~~See the RSpec tests for more examples.~~

## License

Licensed under the MIT license.
