require "spec_helper"
require "xmlrpc/client"

RSpec.describe AbutmentOdoo do

  describe "#uid" do
    it "get login user id success" do
      # common = XMLRPC::Client.new2("#{configuration.url}/xmlrpc/2/common")
      # uid = common.call('authenticate', configuration.database_name, configuration.username, configuration.password, {})
      # expect(uid).to eq(1)
    end
  end

end
