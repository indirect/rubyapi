module ApplicationHelper
  GITHUB_REPO = "https://github.com/ruby/ruby/blob/".freeze

  def homepage?
    current_page?(root_path) || current_page?(versioned_root_path(version: ruby_version))
  end

  # Map a method source file into a url to Github.com
  def github_url(ruby_doc)
    version, file, line = ruby_doc.source_location.split(":")
    github_version = version.tr(".", "_")
    path = File.join "v#{github_version}", file

    URI.join(GITHUB_REPO, path, "#L#{line}").to_s
  end
end
