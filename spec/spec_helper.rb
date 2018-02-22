require 'rspec/core'
require 'rspec'

RSpec.configure do |config|
  config.before(:all) do
    AbutmentOdoo.configure do |config|
      config.url           = 'https://demo2.odoo.com'
      config.database_name = 'demo_110_1519291233'
      config.username      = 'admin'
      config.password      = 'admin'
    end
  end
end