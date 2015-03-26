# Aop-Client

Ruby SDK for Rails to support usage of Alibaba API.

Aop-Client is built to run along with Rails. It wraps usage for Alibaba Post Product API. Currently, it only supports [these api].

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aop-client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aop-client

## Rails

Run install generator to get start.

```ruby
rails generate aop_client:install
```

The generator will create a YAML file at [`config/aop-client.yml`].

## Usage

For better usage, please refer to [spec/response].

```ruby
# Initialize an API object
api = AopClient::Api.new

# Call Alibaba API
# Omit 'alibaba.icbu' from alibaba method name
# provide require information in a hash
aop.call('category.postcat.get', { cat_id: 0 })

# when success
api.error #=> nil
api.data  #=> [{ cat_id: 1, child_ids: [2, 3], en_name: 'Agriculture', ... }]

# when error
api.data  #=> []
api.error #=> { code: 15, msg: 'Remote service error', sub_code: 'isv.100000', sub_msg: 'category does not exist', ... }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/aop-client/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[`config/aop-client.yml`]:https://github.com/yoolk/aop-client/blob/master/lib/generators/aop-client/templates/aop-client.yml
[these api]:http://open.taobao.com/us/portal/api_cat_detail.htm?scope_id=11611&category_id=102
[spec/response]:https://github.com/yoolk/aop-client/tree/master/spec/lib/aop-client/response