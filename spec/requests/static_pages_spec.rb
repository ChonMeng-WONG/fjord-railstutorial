require 'spec_helper'

describe "StaticPages" do
    subject{ page }

  shared_examples_for "all static pages" do
    it { should have_content(name) }
    it { should have_title(full_title(title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:name) {'Sample'}
    let(:title){''}

    it_should_behave_like "all static pages"
    it { should_not have_title('ほーむ') }
  end

  describe "Help page" do
    before { visit help_path }
    let(:name) {'へるぷ'}
    let(:title){'へるぷ'}

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:name) {'あばうと'}
    let(:title){'あばうと'}

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:name) {'こんたくと'}
    let(:title){'こんたくと'}

    it_should_behave_like "all static pages"
  end

    it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('あばうと'))
    click_link "Help"
    expect(page).to have_title(full_title('へるぷ'))
    click_link "Contact"
    expect(page).to have_title(full_title('こんたくと'))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title(''))
    click_link "sample app"
    expect(page).to have_title(full_title(''))
  end
end
