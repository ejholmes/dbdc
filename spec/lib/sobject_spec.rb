
require 'spec_helper'

describe Dbdc::Client do
  subject { Dbdc::Client.new :username => 'foo', :password => 'bar', :security_token => 'token',
                             :client_id => 'client_id', :client_secret => 'client_secret' }

  context "when authenticated" do
    before(:each) { VCR.use_cassette('authenticate_success_response') { subject.authenticate } }
    before(:each) { VCR.use_cassette('describe_account_success') { subject.materialize('Account') } }

    it "does something" do
      account = Account.new
      account.Name = 'hello world'
    end
  end
end
