require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
render_views
  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to be_success
    end

    it "should have the right title" do
    	get 'new'
    	assert_select "title", "Sign up"
    end
  end

end
