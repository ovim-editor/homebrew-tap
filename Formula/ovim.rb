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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.0.0/ovim-v1.0.0-aarch64-apple-darwin.tar.gz"
      sha256 "de0d894f576657442b584c1069caa394e5d80daea94c6ac40cb028befce6d62c"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.0.0/ovim-v1.0.0-x86_64-apple-darwin.tar.gz"
      sha256 "bb71d09591af68f3f6a52787d2302a7a323009e4f084d60808f70e5e0f1b85f7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.0.0/ovim-v1.0.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "c5c3c9865a506bcd38b78f71ef07a79778c3296042b6dd4b26590916eb2f0571"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.0.0/ovim-v1.0.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c688ba3a01b88df18ed190f28e8fbc83c2d09143b5309acc67caf30dba93d8ad"
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
