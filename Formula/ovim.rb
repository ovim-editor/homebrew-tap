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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.4/ovim-v1.2.4-aarch64-apple-darwin.tar.gz"
      sha256 "0d7603537704cec394ec58dc637ca682c7db7ec51256b87d0ff204ed2d6758a3"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.4/ovim-v1.2.4-x86_64-apple-darwin.tar.gz"
      sha256 "8501f2eacc76938b05d60caf2d52010c6d7378a300e8ac628f158a4cad8ab5ac"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.4/ovim-v1.2.4-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6ead4b2d0e1736522807b30c665f87b6d04d8d395705fb16b0acb20b9e86da41"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.4/ovim-v1.2.4-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eeb86021c8b8bea527ac1bc3c23b6c1f6ebbce8b81c7c667500b0083c2fcc980"
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
