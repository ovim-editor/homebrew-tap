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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.15/ovim-v0.1.15-aarch64-apple-darwin.tar.gz"
      sha256 "ab1b019a7633d9affa1fa34a58b66841811cca33b9329c357cb58e530c2ca5ce"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.15/ovim-v0.1.15-x86_64-apple-darwin.tar.gz"
      sha256 "5e783417d6f81bc1ab7dbbb1b63d729bd3738804429ac0010c184f02cfece58e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.15/ovim-v0.1.15-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ba3df0cb0a61aca38ff2aceaae2ffb0c5e666ef774bd4157d29f6f45cb372442"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.15/ovim-v0.1.15-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8acb3ec63a51824347160ee24089365c7d0b6316725e8200ff3e4a522af67dd7"
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
