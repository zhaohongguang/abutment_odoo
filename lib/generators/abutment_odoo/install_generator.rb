module AbutmentOdoo
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      desc "Creates AbutmentOdoo initializer for your application"

      def copy_initializer
        template "abutment_odoo.rb", "config/initializers/abutment_odoo.rb"
      end
    end
  end
end