require "abutment_odoo/version"
require "xmlrpc/client"

module AbutmentOdoo

  class << self

    def initialize(options={})
      @url           = options[:url]
      @database_name = options[:database_name]
      @password      = options[:password]
      @username      = options[:username]
    end

    def uid(options = {})
      common = XMLRPC::Client.new2("#{@url}/xmlrpc/2/common")
      uid = common.call('authenticate', @database_name, @username, @password, {})
    end

    def search()
      operate_models(model_name, 'search', options = {})
    end

    def operate_models(model_name, operate_type, options = {})
      models = XMLRPC::Client.new2("#{url}/xmlrpc/2/object").proxy

      models.execute_kw(@database_name, uid, @password, "#{model_name}", "#{operate_type}", [], {} )
    end
  end
end
