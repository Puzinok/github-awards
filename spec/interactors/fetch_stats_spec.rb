# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchStats, type: :interactor do
  describe '.call' do
    before(:each) { stub_github }
    let(:url) { 'https://github.com/rspec/rspec-rails' }
    let(:wrong_url) { 'https://github.com/error/' }

    it 'sussess' do
      expect(FetchStats.call(url: url)).to be_a_success
      expect(FetchStats.call(url: url).contributors).to be_a(Array)
    end

    it 'failure' do
      expect(FetchStats.call(url: wrong_url)).to be_a_failure
    end
  end
end
