class Ovim < Formula
  desc "Fast terminal editor with Vim keybindings, Lua, LSP, and AI"
  homepage "https://github.com/ovim-editor/ovim"
  license "MIT"

  head do
    url "https://github.com/ovim-editor/ovim.git", branch: "main"
    depends_on "rust" => :build
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.0/ovim-v1.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "423abe63a33414ab16918cbe4a4edbb87eb8dcdb522c6abd4b99e92e2f0b2436"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.0/ovim-v1.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "1ace9e76331df2fc5852fb15000831c97e6f2c8f17c71113c5ad17f239a42ce7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.0/ovim-v1.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e8ad51e3f7bab70ddbaa643c84cca881a93a0aaeaa604eb87afe684578bd4178"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.0/ovim-v1.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "45be81e78dd6e5bf11b314f94e4b59117162b24bef28a203763cfffcf380b365"
    end
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args(path: "ovim")
    else
      bin.install "ovim"
    end
  end

  test do
    assert_match "Oxidized Vim", shell_output("#{bin}/ovim --help")
  end
end
