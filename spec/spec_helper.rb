RSpec.configure do |config|
  config.before(:all) do
    AbutmentOdoo.configure do |config|
      config.url           = 'https://demo3.odoo.com'
      config.database_name = 'demo_110_1517313697'
      config.password      = 'admin'
      config.username      = 'admin'
    end
  end
end