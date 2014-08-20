require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
render_views

  describe "GET 'show'" do

    before(:each) do
      @user = User.create!(:name => "name", :email => "email@email.com", :password => "password", :password_confirmation => "password")
    end

    it "should be successful" do
      get :show, :id => @user
      expect(response).to be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should have the right title" do
      get :show, :id => @user
      assert_select "title", @user.name
    end

    it "should include the user's name" do
      get :show, :id => @user
      assert_select "h1", @user.name
    end

    # it "should have a profile image" do
    #   get :show, id: => @user
    #   assert_select "h1>img", @user.name
    # end
  end
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
