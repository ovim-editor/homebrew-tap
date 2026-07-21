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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.10/ovim-v0.1.10-aarch64-apple-darwin.tar.gz"
      sha256 "afbe16b853a8aaebd95e676d8597d2a48541dd32c54d6481ce418bc958ea98c9"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.10/ovim-v0.1.10-x86_64-apple-darwin.tar.gz"
      sha256 "394e742f5d850f2de096b0481114176b81a5b333065d14924d7ae17807308fdf"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.10/ovim-v0.1.10-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "16df7dcbb5667b44d1a8c93421373a6821aabffcc9da5d7418ca01fd029d3aac"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.10/ovim-v0.1.10-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6f8481e20e9b55b4b473c3c87236cc9b29acdc9e3155ddb5743ff64a4c6d4769"
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
