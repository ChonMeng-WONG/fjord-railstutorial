=begin
require 'spec_helper'

describe "Static pages" do

  describe "Home page" do

    it "should have the h1 'Sample App'" do
      visit root_path
      expect(page).to have_content('Sample App')
    end

    it "should have the base title" do
      visit root_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    end

    it "should not have a custom page title" do
      visit root_path
      expect(page).not_to have_title('| Home')
    end
  end

  describe "Help page" do

    it "should have the h1 'Help'" do
      visit help_path
      expect(page).to have_content('Help')
    end

    it "should have the title 'Help'" do
      visit help_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Help")
    end
  end

  describe "About page" do

    it "should have the h1 'About Us'" do
      visit about_path
      expect(page).to have_content('About Us')
    end

    it "should have the title 'About Us'" do
      visit about_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | About Us")
    end
  end

  describe "Contact page" do

    it "should have the content 'Contact'" do
      visit contact_path
      expect(page).to have_content('Contact')
    end

    it "should have the title 'Contact'" do
      visit contact_path
      expect(page).to have_title("Ruby on Rails Tutorial Sample App | Contact")
    end
  end
end
=end

require 'spec_helper'
include ApplicationHelper

describe "Static pages" do

  subject { page }
  # テストコードをまとめた
  shared_examples_for "all static pages" do
    it { should have_content(heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
#    it { should have_content('Sample App') }
    let(:heading) {'Sample App'}
    let(:page_title){''}

#    it { should have_title(full_title('')) }
    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }
  end

  describe "Help page" do
    before { visit help_path }

#    it { should have_content('Help') }
    let(:heading) {'Help'}
    let(:page_title){''}

    #it { should have_title(full_title('Help')) }
    it_should_behave_like "all static pages"

  end

  describe "About page" do
    before { visit about_path }

 #   it { should have_content('About Us') }
    let(:heading) {'About Us'}
    let(:page_title){''}

    #it { should have_title(full_title('About Us')) }
    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }

 #   it { should have_content('Contact') }
    let(:heading) {'Contact'}
    let(:page_title){''}

    #it { should have_title(full_title('Contact')) }
    it_should_behave_like "all static pages"

  end
end