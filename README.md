# HumanAttributeValue

Rails provides `.human_attribute_name`, for you to translate model names. But it lacks the same functionality when it comes to attribute values. This gems adds the missing piece, while being as close as possible to the present conventions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "human_attribute_value"
```

And then execute:

    $ bundle

## Usage

Rails defines some conventions for model (attributes) translations, for example `activerecord.models` and `activerecord.attributes`. This gem adds `activerecord.values`.

`config/locales/de.yml`

```yml
---
de:
  activerecord:
    models:
      company: Firma
    attributes:
      company:
        name: Name
        city: Stadt
        size: Größe
    # 
    # This gem adds activerecord.values
    #
    values:
      company:
        city:
          size:
            small: klein
            medium: mittel
            large: groß
          tags:
            company: Firma
            important: wichtig
            green: ökologisch
```

In order to use `human_attribute_value` it needs to be included into your model or your `ApplicationRecord`.

```ruby
class ApplicationRecord < ActiveRecord::Base
  include HumanAttributeValue
end
```

Now you can do the following.

```ruby
company = Company.create(name: "ACME Inc.", city: "Berlin", size: "large")

# assuming your current locale is :de
company.human_attribute_value(:size) # => "groß"
```

It respects serialized arrays as well. Let's assume you have an serialized `tags` array.

```ruby
company = Company.create(name: "ACME Inc.", tags: ["company". "important", "green"])

# assuming your current locale is :de
company.human_attribute_value(:tags) # => ["Firma", "wichtig", "ökologisch"]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nerdgeschoss/human_attribute_value.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
