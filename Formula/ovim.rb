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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.7.0/ovim-v1.7.0-aarch64-apple-darwin.tar.gz"
      sha256 "eee0f02b9cc841ec013dc83ae029f800aedf2a282834efb731a999f394f0a8a5"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.7.0/ovim-v1.7.0-x86_64-apple-darwin.tar.gz"
      sha256 "367f44ff0490690ace5120ec96598b07d1afddc198216701ed380a0e83d492c2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.7.0/ovim-v1.7.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5541d34f0622dce559884177411924c73696f9db2642f0c7b57894d53a33d588"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.7.0/ovim-v1.7.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "627f4be5f41ad745c93f664c7c59bddf7e9c96e00b0cdc7ee72a8a6741550ae8"
    end
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args(path: "ovim"),
             "--no-default-features", "--features", "lua,vendored", "--bin", "ovim"
    else
      bin.install "ovim"
    end
  end

  test do
    assert_match "Oxidized Vim", shell_output("#{bin}/ovim --help")
  end
end
