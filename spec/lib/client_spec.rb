require 'spec_helper'

describe Dbdc::Client do
  subject { Dbdc::Client.new :username => 'foo', :password => 'bar', :security_token => 'token',
                             :client_id => 'client_id', :client_secret => 'client_secret' }

  describe ".authenticate" do
    context "with valid credentials" do
      it "authenticates" do
        VCR.use_cassette 'authenticate_success_response' do
          expect {
            subject.authenticate
          }.to_not raise_error
        end
      end
    end

    context "with invalid credentials" do
      subject { Dbdc::Client.new :username => 'foo', :password => 'bad', :security_token => 'token',
                                 :client_id => 'client_id', :client_secret => 'client_secret' }

      it "doesn't authenticate" do
        VCR.use_cassette 'authenticate_error_response' do
          expect {
            subject.authenticate
          }.to raise_error Dbdc::Error
        end
      end
    end
  end

  context "when authenitcated" do
    before(:each) { VCR.use_cassette('authenticate_success_response') { subject.authenticate } }

    describe ".list_sobjects" do
      it "lists all sobjects" do
        VCR.use_cassette 'list_sobjects_success' do
          puts subject.list_sobjects
        end
      end
    end
  end
end
