require 'rails_helper'

RSpec.describe PagesController, :type => :controller do
  render_views

  describe "GET home" do
    it "returns http success" do
      get :home
      expect(response).to be_success
    end

    it "should have the right title" do
      get 'home'
      assert_select "title", "Ruby on Rails Tutorial Sample App | Home"
    end
  end

  describe "GET contact" do
    it "returns http success" do
      get :contact
      expect(response).to be_success
    end

    it "should have the right title" do
      get 'contact'
      assert_select "title", "Ruby on Rails Tutorial Sample App | Contact"
    end
  end

  describe "GET about" do
    it "returns http success" do
      get :about
      expect(response).to be_success
    end

    it "should have the right title" do
      get 'about'
      assert_select "title", "Ruby on Rails Tutorial Sample App | About"
    end
  end

end
