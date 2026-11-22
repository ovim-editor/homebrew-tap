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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.8.0/ovim-v1.8.0-aarch64-apple-darwin.tar.gz"
      sha256 "bf240b25853789986f53ec4827e1e96469ce49bcace2ff6434f7d620b78b40e0"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.8.0/ovim-v1.8.0-x86_64-apple-darwin.tar.gz"
      sha256 "9b0d54c8e743e6fb6cd49977b68616670c8bee3dd63a854fb64bd28c23c4fe51"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.8.0/ovim-v1.8.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e2a733a449e74c6b77708640b9277e9e9b6938e44aaae074d0d13980bc51a962"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.8.0/ovim-v1.8.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b7499b4ad7ecedeb2b61894bbeb29e4128b6fcd7e44de566328b3df2e740d4a6"
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
