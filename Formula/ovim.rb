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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.11/ovim-v0.1.11-aarch64-apple-darwin.tar.gz"
      sha256 "e5cfb66bb2d5699525fa49bc9dc7e481cb6d66b86d6d7edcb99037c0cce12e98"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.11/ovim-v0.1.11-x86_64-apple-darwin.tar.gz"
      sha256 "7f71a65fa691fd3a97e7de1ceb52916a81b51601df6ac064bac724160d89432d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.11/ovim-v0.1.11-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "728c93867fa7bc014e4fedbf4fe5bbf0978647da628f26884354444bc78275f3"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.11/ovim-v0.1.11-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d352685aedece0c7c07ad5579159edc5dce5bc95f3fcb1c86e955e9b371c071f"
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
