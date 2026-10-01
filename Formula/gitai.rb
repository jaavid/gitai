class Gitai < Formula
  desc "AI-assisted Conventional Commits with a terminal-native workflow"
  homepage "https://github.com/jaavid/gitai"
  head "https://github.com/jaavid/gitai.git", branch: "main"
  license "MIT"

  depends_on "gum"
  depends_on "jq"

  def install
    bin.install "gitai"
  end

  test do
    system "git", "init", testpath
    assert_match "gitai 0.2.0", shell_output("#{bin}/gitai --version")
  end
end
