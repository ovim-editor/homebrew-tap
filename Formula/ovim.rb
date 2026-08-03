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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.18/ovim-v0.1.18-aarch64-apple-darwin.tar.gz"
      sha256 "22b5ce674aec1f85929dd540b55044f44909ce6a7f788cd5e1129884c2517fc6"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.18/ovim-v0.1.18-x86_64-apple-darwin.tar.gz"
      sha256 "df1c663cfd72af5615e4e6a63b18956dace30d61757021c44a29ba5c5baa5650"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.18/ovim-v0.1.18-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ed0795bfbd5dc6935bfb05d9529af3d437737343633746ff75f4f97e42475962"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.18/ovim-v0.1.18-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1793d2cee2c5ab893d79b8be6a9643ef1ff270aa0e574fa970daee7dedc091f2"
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
