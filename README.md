# FacePlusPlus Ruby SDK

A Ruby interface to the FacePlusPlus API.

## Supported Ruby Versions

This sdk has been tested against the following Ruby versions:

- 1.9.3_p286 and upper

## Installation

```bash
gem build facepp.gemspec
gem install *.gem
```

## Get Started

```ruby
require 'facepp'

api = FacePP::Client.new 'YOUR_API_KEY', 'YOUR_API_SECRET'
puts api.v3.detect image_file: '/tmp/0.jpg'
```

~~See the RSpec tests for more examples.~~

## License

Licensed under the MIT license.
