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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.0.1/ovim-v1.0.1-aarch64-apple-darwin.tar.gz"
      sha256 "28ec95a642e4906e09da303115db2d9a0fb8d8bddb6257819ba4f50a126b7867"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.0.1/ovim-v1.0.1-x86_64-apple-darwin.tar.gz"
      sha256 "b228669418a8c8eb5e04152dbff395829e049fb5fb17b6bd24bf85624d7823a3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.0.1/ovim-v1.0.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "02bee5c0236f41bf11a21cf72a97c11dc3c8dd9aada1f1c8448e967652580637"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.0.1/ovim-v1.0.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b0ca6be2c5b43edc6635ff94859964144e429fde7e6295c8441f433d64f308a5"
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
