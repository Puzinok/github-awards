class GithubApi::UrlParser
  include Interactor

  def call
    if validate_url(context.url)
      context.url = convert_url(context.url)
    else
      context.fail!(message: 'Url is not correct.')
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
end
