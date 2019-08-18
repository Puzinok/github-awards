require 'rails_helper'

feature 'User can download pdf or zip award', %q{
  As an user
  I would like to be able to download awards
} do

  before(:each) { stub_github }

  scenario 'User can download zip', js: true do
    visit root_path
    fill_in 'Repo url', with: 'https://github.com/rails/rails'
    click_on 'search'

    click_link 'download zip(3)'
    expect(response_headers['Content-Type']).to eq('application/zip')
  end

  scenario 'User can download pdf', js: true do
    visit root_path
    fill_in 'Repo url', with: 'https://github.com/rails/rails'
    click_on 'search'

    click_link 'dchelimsky'
    expect(response_headers['Content-Type']).to eq('application/pdf')
  end
end
