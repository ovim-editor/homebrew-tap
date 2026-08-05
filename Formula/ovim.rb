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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.24/ovim-v0.1.24-aarch64-apple-darwin.tar.gz"
      sha256 "aae013ecc1e97a60987c8b0ca9a05bbdb0e6cc0488b6747e7e4e1e10d6be73ee"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.24/ovim-v0.1.24-x86_64-apple-darwin.tar.gz"
      sha256 "8381e4bde88690b18cdfcc3c318c3d0ad6542f8ef5581d086114991ad186d52c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.24/ovim-v0.1.24-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "936793b1048ceb7c11d0af9c4a7497ed99fab413ca0785403c8144492cd3018b"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.24/ovim-v0.1.24-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7a50d85efad0fb453bb23e5764bee7fb428b29b3dc5fc1fe4b929f36f68867a7"
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
