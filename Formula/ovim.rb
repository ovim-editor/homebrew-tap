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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.23/ovim-v0.1.23-aarch64-apple-darwin.tar.gz"
      sha256 "170628d98ddbea67bef5f20ac1b897e80d20b693a99522cc10dd2440cdaaba73"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.23/ovim-v0.1.23-x86_64-apple-darwin.tar.gz"
      sha256 "98c2ae8f20b1b2d8eae11974673868088667cf3b8a547f535807eba14675cbd4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.23/ovim-v0.1.23-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "50073a18cac820ac8988ae9dc6551b23de6e89240ffa2c2bc78b1cd8a4ec19c4"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.23/ovim-v0.1.23-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f086bbb82675af2a3efcc813c69d760f650f62f2965d9d5527666c4602733f6d"
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
