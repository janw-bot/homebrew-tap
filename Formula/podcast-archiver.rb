class PodcastArchiver < Formula
  include Language::Python::Virtualenv

  desc "Archive all episodes from your favorite podcasts"
  homepage "https://github.com/janw/podcast-archiver"
  license "MIT"
  head "https://github.com/janw/podcast-archiver.git", branch: "main"

  url "https://files.pythonhosted.org/packages/8f/e5/8755a83ff405dcca8cab041266d61acfff0ab385dd20f36a3a51a48c6469/podcast_archiver-1.4.2.tar.gz"
  sha256 "8893c6da5a5e345b222e2306219c30f091bc950d1416efedd36f18fe30577477"

  depends_on "python@3.12"

  def python3
    "python3.12"
  end

  def std_pip_args(prefix: self.prefix, build_isolation: false)
    ["--verbose", "--ignore-installed"]
  end

  def install
    venv = virtualenv_create(libexec, python3, system_site_packages: false)
    venv.pip_install buildpath
    bin.install_symlink(["#{libexec}/bin/podcast-archiver"])
    generate_completions_from_executable(bin/"podcast-archiver", shells: [:zsh, :fish], shell_parameter_format: :click)
  end

  test do
    assert_match "podcast-archiver, ", shell_output(bin/"podcast-archiver --version")
  end
end
