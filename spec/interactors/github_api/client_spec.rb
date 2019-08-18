require 'rails_helper'

RSpec.describe GithubApi::Client, type: :interactor do
  describe '.call' do
    before(:each) { stub_github }

    let(:url) { 'https://api.github.com/repos/rails/rails' }
    let(:wrong_url) { 'https://api.github.com/repos/error' }

    let(:client) { GithubApi::Client.call(url: url) }
    let(:fail_client) { GithubApi::Client.call(url: wrong_url) }

    it 'success and return response body' do
      expect(client).to be_a_success
      expect(client.body).to be_a(Array)
      expect(client.body.first).to be_a(Hash)
    end

    it 'failure and return error message' do
      expect(fail_client).to be_a_failure
      expect(fail_client.message).to eq('404 Not Found')
    end
  end
end