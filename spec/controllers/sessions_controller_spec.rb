require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "POST create" do
    it "creates a user" do
      VCR.use_cassette("DO_NOT_DELETE_exchange_slack_code_for_token") do
        params = {"code"=>"2329094327.101480729555.5b65e716cc",
                  "state"=>""}

        expect{post :create, params: params}.to change{User.count}.from(0).to(1)
      end
    end
  end

  describe "POST create" do
    it "fails to create a user" do
      params = {"error"=>"access_denied",
                "state"=>""}

      expect{post :create, params: params}.to_not change{User.count}.from(0)
    end
  end
end