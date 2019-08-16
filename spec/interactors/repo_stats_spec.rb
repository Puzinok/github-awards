require 'rails_helper'

RSpec.describe RepoStats, type: :interactor do
  describe '.call success' do
    before(:each) { stub_github }

    let(:client) { RepoStats.call(repo: repo) }
    let(:repo) { { owner: 'rspec', repo: 'rspec-rails' } }

    let(:error_client) { RepoStats.call(repo: wrong_repo) }
    let(:wrong_repo) { { owner: 'error', repo: 'rspec-fail' } }

    it 'success and return contributors' do
      expect(client).to be_a_success
      expect(client.contributors.first)
        .to eq(login: 'dchelimsky', avatar_url: 'https://avatars3.githubusercontent.com/u/1075?v=4')
    end

    it 'failure and return error message' do
      expect(error_client).to be_a_failure
      expect(error_client.message).to eq('Not Found')
    end
  end
end
