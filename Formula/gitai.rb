class Gitai < Formula
  desc "AI-assisted Conventional Commits with a terminal-native workflow"
  homepage "https://github.com/jaavid/gitai"
  url "https://github.com/jaavid/gitai.git", revision: "f9bd69c4958b3ae10ae83d19cc8d2b490ca4fd0b"
  version "0.3.0"
  head "https://github.com/jaavid/gitai.git", branch: "main"
  license "MIT"

  depends_on "gum"
  depends_on "jq"

  def install
    bin.install "gitai"
  end

  test do
    system "git", "init", testpath
    assert_match "gitai 0.3.0", shell_output("#{bin}/gitai --version")
  end
end
