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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.12/ovim-v0.1.12-aarch64-apple-darwin.tar.gz"
      sha256 "d3e6f461635b8654bf477e79e928727887d51b1ce34ee864ac3e6c8625d713ee"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.12/ovim-v0.1.12-x86_64-apple-darwin.tar.gz"
      sha256 "f86ae22805e0bb0591ce397b297e41a0fda2ed8da9b2ef3757c7d3bf0d231115"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.12/ovim-v0.1.12-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3c2794495bb709b2f3cb0e601cfc658b3e0dbbe28c3bd6a612a5c58e6a7ef738"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.12/ovim-v0.1.12-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2e886ba49bf6502bcaa529ac60639f47b20842cb119a3709d0607a328d4698da"
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
