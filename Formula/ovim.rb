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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.1/ovim-v1.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "70eeda0346e03ac9a164d54b88bc8366b77a79eeefd9f80fff85d0d44ebc286e"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.1/ovim-v1.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "59621b5fe419f6ee2c59a7cc689f79ce8dbf0cb43cec8244e1ed3ec14ce4cbe9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.1/ovim-v1.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "456a90dfe580f879f960cf8235bb6d23a531c1ec98f92c52196bfe01aa231916"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.1/ovim-v1.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a7ff20929c3d434682383b5426fa2797e0738754d219f546e4e07c2913c1119c"
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
