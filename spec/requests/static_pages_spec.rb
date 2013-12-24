require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the content 'iNat Lite'" do
      visit '/static_pages/home'
      page.should have_content('iNat Lite')
    end
  end
  
  describe "About page" do

    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      page.should have_content('About Us')
    end
  end
end