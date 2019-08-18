class FetchStats
  include Interactor::Organizer

  organize GithubApi::UrlParser, GithubApi::Client, GithubApi::RepoStats
end
