require 'spec_helper'

RSpec.describe "LayoutLinks", :type => :request do
  
  describe "GET /layout_links" do
    it "should have a Home page at '/'" do
      get '/'
      assert_select "title", "Home"
    end
    it "should have a Contact page at '/contact'" do
      get '/contact'
      assert_select "title", "Contact"
    end
    it "should have a About page at '/about'" do
      get '/about'
      assert_select "title", "About"
    end
    it "should have a Help page at '/help'" do
      get '/help'
      assert_select "title", "Help"
    end
  end
end
