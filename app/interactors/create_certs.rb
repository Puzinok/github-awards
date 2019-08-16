class CreateCerts
  include Interactor::Organizer

  organize UrlParser, RepoStats, CreatePdf
end
