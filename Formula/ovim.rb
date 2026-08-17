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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.7/ovim-v1.2.7-aarch64-apple-darwin.tar.gz"
      sha256 "445a48a7ef8b9cd2324a0a9466b29781d0235b6ae50bcad805d4ac7449aa2bd3"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.7/ovim-v1.2.7-x86_64-apple-darwin.tar.gz"
      sha256 "5977837b46b14ffe28febe753de0a704e7d1fc849a20adfa4b6e1e27b6849211"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.7/ovim-v1.2.7-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3a3e4354615b3e4185d185b0af1e0d362976ffedc8ea7676165474da41a4a0ce"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.7/ovim-v1.2.7-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "63c3ffdfb855d79b22f0c40cfad0c007a7c32bb432a1d36c683fc73f9b42a9ab"
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
