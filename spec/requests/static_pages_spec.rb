require 'spec_helper'

describe "Static pages" do
  subject { page }
  
  describe "Home page" do
    before { visit root_path }
    
    it { should have_selector('h1', text: 'iNat Lite') }
  end
  
  describe "About page" do
    before { visit about_path }
    
    it { should have_content('About Us') }
  end
end