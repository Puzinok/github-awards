require 'rails_helper'

feature 'User can show repo authors', %q{
  In order to show top 3 authors of repo
  As an user
  I would like to be able to input repo and get authors list
} do

  before(:each) { stub_github }

  scenario 'User can see links to pdf', js: true do
    visit root_path
    fill_in 'Repo url', with: 'https://github.com/rails/rails'
    click_on 'search'

    expect(page).to have_link('JonRowe')
  end

  scenario 'User can see link to zip file', js: true do
    visit root_path
    fill_in 'Repo url', with: 'https://github.com/rails/rails'
    click_on 'search'

    expect(page).to have_link('download zip(3)')
  end

  scenario 'User can see error if repo url not correct', js: true do
    visit root_path
    fill_in 'Repo url', with: 'https://BUGhub.com/rails/rails'
    click_on 'search'

    expect(page).to have_content('Url not correct.')
  end

  scenario 'User can see if repo not found', js: true do
    visit root_path
    fill_in 'Repo url', with: 'https://github.com/error/rails'
    click_on 'search'

    expect(page).to have_content('404 Not Found')
  end
end
