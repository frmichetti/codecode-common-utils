# CodeCode::Common::Utils

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/codecode/common/utils`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'common-utils'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install codecode-common-utils

## Usage
```ruby
require 'common-utils'

# Create a whatever object
 object = {
        'first_key' => 'first_value',
        'second_key' => 'second_value',
        'third_key' => 'third_value'
    }

# Create a whatever nested object
    other_object = {
        'first_key' => 'string',
        'second_key' =>  2.0,
        'third_key' => 5,
        'fourth_key' => :test
    }

# Include nested object inside of a main object
    100.times do |n|
      object["nested object #{n}"] = other_object
    end

# Take a look on Result
    object = CodeCode::Common::Utils::Hash.symbolize_keys object

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/common-utils. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Common::Utils project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/common-utils/blob/master/CODE_OF_CONDUCT.md).
