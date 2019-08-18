class GithubApi::UrlParser
  include Interactor

  def call
    if validate_url(context.url)
      context.url = convert_url(context.url)
      context.repo_params = repo_name(context.url)
    else
      context.fail!(message: 'Url not correct.')
    end
  end

  private

  def validate_url(url)
    url.match?(/^https:\/\/github.com\/\S+\/\S+$/i)
  end

  def convert_url(url)
    return url if url.match?(/https:\/\/api.github.com\/repos/)

    owner, repo_name = url[/github.com\/(\S+\/\S+)/i, 1].split('/')
    "https://api.github.com/repos/#{owner}/#{repo_name}/stats/contributors"
  end

  def repo_name(url)
    url[/github.com\/(\S+\/\S+)/i, 1]
  end
end
