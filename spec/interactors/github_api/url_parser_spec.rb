# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubApi::UrlParser, type: :interactor do
  describe '.call' do
    let(:url) { 'https://github.com/rspec/rspec-rails' }
    let(:wrong_url) { 'https://github.com/rspec' }
    let(:converter) { GithubApi::UrlParser.call(url: url) }
    let(:wrong_converter) { GithubApi::UrlParser.call(url: wrong_url) }

    it 'success convert to api link' do
      expect(converter).to be_a_success
      expect(converter.url).to eq("https://api.github.com/repos/rspec/rspec-rails/stats/contributors")
    end

    it 'failure if url is wrong' do
      expect(wrong_converter).to be_a_failure
      expect(wrong_converter.message).to eq('Url is not correct.')
    end
  end
end
