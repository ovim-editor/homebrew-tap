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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.25/ovim-v0.1.25-aarch64-apple-darwin.tar.gz"
      sha256 "84af82a068db2610b18c29d2f1b212f508253f483c3a5b7cae42a1e6179e5234"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.25/ovim-v0.1.25-x86_64-apple-darwin.tar.gz"
      sha256 "2f57198eb5decfdc898367a14a34c6676d62a0c38e4d7da33df6d00527219751"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.25/ovim-v0.1.25-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "34332c661501cbcf1ebe8c066fe2d366e0a26109c64bb3d4a235cf7c8d81c0d1"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.25/ovim-v0.1.25-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "df1cde1c64e5cdf33851663744ce313498643c306a549609e41f2f165399c478"
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
