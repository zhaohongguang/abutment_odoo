require "abutment_odoo/version"
require "xmlrpc/client"

module AbutmentOdoo

  class << self
    attr_accessor :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    # 获取登陆用户的ID
    def uid(options = {})
      common = XMLRPC::Client.new2("#{configuration.url}/xmlrpc/2/common")
      common.call('authenticate', configuration.database_name, configuration.username, configuration.password, {})
    end

    # Calling methods
    def models
      models = XMLRPC::Client.new2("#{configuration.url}/xmlrpc/2/object").proxy
    end

    # odoo 接口search 操作
    # @example
    #   AbutmentOdoo.search('res.partner', { is_company: true, customer: true, offset: 10, limit: 5 }) => [1]
    #
    # offset: 10, limit: 5 分也和每页的条数
    # @params model_name [String] 模型名字
    # @params options [Hash] 搜索条件
    # @return [Array] ids ID数组
    def search(model_name, options = {})
      search_parameter = []
      constraint_condition = { }

      options.each do |key, value|
        if key == 'offset' || key == 'limit'
          constraint_condition[key] = value
        else
          search_parameter << [key.to_s, '=', value]
        end
      end

      operate_models(model_name, 'search', search_parameter, constraint_condition)
    end

    # odoo 接口read 操作
    # @example
    #   AbutmentOdoo.read('res.partner', [id], {fields: ['name', 'country_id', 'id'], offset: 10, limit: 5})
    #
    # @params model_name [String] 模型名字
    # @params ids [Array] ID 数组
    # @params options [Hash] 模型字段和查询条数
    # @return [Array] records list
    def read(model_name, ids, options = { })
      operate_models(model_name, 'search', ids, options)
    end

    # odoo 接口创建记录操作
    # @example
    #   AbutmentOdoo.create_records('res.partner' [{name: "New Partner"}]) => [78]
    #
    # @params model_name [String] 模型名字
    # @params options [Hash] 搜索条件
    # @return [Array] ids ID数组
    def create_records(model_name, parameter = [])
      ids = []
      parameter.each do |item|
        ids << create(model_name, 'create', item)
      end
      ids
    end

    # 新增模型
    # @example
    #   AbutmentOdoo.create_models({model: 'x_custom_model', state: 'manual'}) => 78
    #
    # @params parameter [Hash] 搜索条件
    # @return int id 返回创建的ID
    def create_models(parameter = {})
      create('ir.model', 'create', parameter)
    end

    # 新增模型字段
    # @example
    #   AbutmentOdoo.create_models({'model_id': id, name: 'x_cloumn_name', ttype: 'char', state: "manual", required: true}) => [78]
    #
    # @params parameter [Array] 搜索条件
    # @return int id 返回创建的ID
    def create_fields(parameter = [])
      ids = []
      parameter.each do |item|
        ids << create('ir.model.fields', 'create', item)
      end
      ids
    end

    # 创建记录公共方法
    def create(model_name, operate_type, parameter)
      models.execute_kw(configuration.database_name, uid, configuration.password, "#{model_name}", "#{operate_type}", [] << parameter)
    end

    # 获取模型中的字段
    def get_fields(model_name, parameter)
      operate_models(model_name, 'fields_get', item)
    end

    def operate_models(model_name, operate_type, parameter, constraint_condition = { })
      models.execute_kw(configuration.database_name, uid, configuration.password, "#{model_name}", "#{operate_type}", [] << parameter, constraint_condition )
    end

    # 公共方法获取记录
    def records(model_name, operate_type, parameter)

    end

  end

  class Configuration
    attr_accessor :url, :database_name, :password, :username

    def initialize
      @url           = ''
      @database_name = ''
      @password      = ''
      @username      = ''
    end
  end
end
