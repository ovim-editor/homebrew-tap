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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.5/ovim-v1.2.5-aarch64-apple-darwin.tar.gz"
      sha256 "5ee623f8f7369c9536fe547cdfda54e2c8853492349743d5764aea6dbd812141"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.5/ovim-v1.2.5-x86_64-apple-darwin.tar.gz"
      sha256 "3a97d0558cba895c219e024e89434686daecd7416ef629a3da4f7cbeeec42b25"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.5/ovim-v1.2.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e7d77f87eee65355a8eedf8b412eb6a50ce55860fdc1c5c188a1aad10b2c0faa"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.5/ovim-v1.2.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "651bb16b7abe01433618a16cbf452255d662f1eb87ef73ce60341f2b0c168aa2"
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
