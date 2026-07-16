class Ovim < Formula
  desc "Fast terminal editor with Vim keybindings, Lua, LSP, and AI"
  homepage "https://github.com/ovim-editor/ovim"
  version "0.1.6"
  license "MIT"

  head do
    url "https://github.com/ovim-editor/ovim.git", branch: "main"
    depends_on "rust" => :build
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.6/ovim-v0.1.6-aarch64-apple-darwin.tar.gz"
      sha256 "21b02941ac5e7a8492173a61f2597a188087d071b48cfaa88f60a1cf442633c1"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.6/ovim-v0.1.6-x86_64-apple-darwin.tar.gz"
      sha256 "f13cebc9a59e5d10be05c10c3fc33b652822a7dffb7b1e264aec4435ac9576f9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.6/ovim-v0.1.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b57a8590871631dc38d4be5c71173fcbefb35b8c086b8ba1f53d1e185d26514f"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.6/ovim-v0.1.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "85074a3c56e93fd912466d0fe68febf577f9709ed3c00eaff6e5818a39d483a9"
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
