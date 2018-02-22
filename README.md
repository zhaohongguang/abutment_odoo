# AbutmentOdoo

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/abutment_odoo`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'abutment_odoo', '0.1.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install abutment_odoo

## Usage

You'll need to configure it in config/initializers/abutment_odoo.rb

    $ rails g abutment_odoo:install

```ruby
AbutmentOdoo.configure do |config|
  # Set your odoo url
  config.url = 'https://demo2.odoo.com'

  # Set odoo's database name
  config.database_name = 'demo_110_1519291233'

  # Set login user name
  config.username = 'admin'

  # Set login password
  config.password = 'admin'
end
```


## Example

`search()` takes a mandatory domain filter (possibly empty), and returns the database identifiers of all records matching the filter. To list customer companies for instance

By default a search will return the ids of all records matching the condition, which may be a huge number. `offset:` and `limit:` parameters are available to only retrieve a subset of all matched records.

```ruby
AbutmentOdoo.search('res.partner', { is_company: true, customer: true, offset: 10, limit: 5 })
```
------

Record data is accessible via the `read()` method, which takes a list of ids (as returned by `search()`) and optionally a list of fields to fetch. By default, it will fetch all the fields the current user can read, which tends to be a huge amount.

```ruby
AbutmentOdoo.read('res.partner', [id], {fields: ['name', 'country_id', 'id'], offset: 10, limit: 5})
```
------

`search_read()` shortcut which as its name suggests is equivalent to a search() followed by a read(), but avoids having to perform two requests and keep ids around.

```ruby
AbutmentOdoo.search_read('res.partner', { is_company: true, customer: true, fields: ['name', 'country_id', 'id'], offset: 10, limit: 5 }
```
------

Rather than retrieve a possibly gigantic list of records and count them, `search_count()` can be used to retrieve only the number of records matching the query.
```ruby
AbutmentOdoo.search_count('res.partner', { is_company: true, customer: true })
```
------

`fields_get()` can be used to inspect a model's fields and check which ones seem to be of interest.

```ruby
AbutmentOdoo.get_fields('res.partner', { attributes: %w(string help type) })
```
------

```ruby
# Records of a model are created using create(). The method will create a single record and return its database identifier.
AbutmentOdoo.create_records('res.partner', [{name: "New Partner"}])

# Records can be updated using write(), return true of false
AbutmentOdoo.write('res.partner', [1], { name: "Newer partner" })

# Records can be deleted in bulk by providing their ids to unlink().
AbutmentOdoo.delete_records('res.partner', 1)
```
------

Create model & Create fields
- "custom" model names must start with x_
- the state must be provided and manual, otherwise the model will not be loaded
- it is not possible to add new methods to a custom model, only fields

```ruby
AbutmentOdoo.create_models({model: 'x_custom_model', state: 'manual'})

AbutmentOdoo.create_models({'model_id': id, name: 'x_cloumn_name', ttype: 'char', state: "manual", required: true})
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/abutment_odoo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
