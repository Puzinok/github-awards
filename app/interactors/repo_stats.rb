require 'rest-client'

class RepoStats
  include Interactor

  def call
    if repo_exist?(context.repo)
      context.contributors = contributors(context.repo)
    else
      context.fail!(message: 'Not Found')
    end
  end

  private

  def api_response(url)
    response = RestClient.get(url)
    raise RestClient::ExceptionWithResponse if response.code != 200

    response
  rescue RestClient::ExceptionWithResponse
    false
  end

  def contributors(repo)
    contrib_data = contributors_data(repo)
    contrib_data = JSON.parse(contrib_data).map { |a| a['author'] }.reverse

    keys = %w[login avatar_url]

    contrib_data.map do |author|
      author.select { |k| keys.include?(k) }.symbolize_keys
    end
  end

  def contributors_data(repo)
    url = "https://api.github.com/repos/#{repo[:owner]}/#{repo[:repo]}/stats/contributors"
    api_response(url).body
  end

  def repo_exist?(repo)
    url = "https://api.github.com/repos/#{repo[:owner]}/#{repo[:repo]}"
    api_response(url)
  end
end
