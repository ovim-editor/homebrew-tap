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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.4.0/ovim-v1.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "f34f2c676c69837f42f9e645698d167e811f3eb1b4faeba95f5bd908a5148c58"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.4.0/ovim-v1.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "741164c8a2c1ea98e2e96897f92119384832ea446773656ab122f08d6c8f94f8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.4.0/ovim-v1.4.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8c35072bb80906abde5687fc3c75485148871d0ade7134976bcf560888aa2ec8"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.4.0/ovim-v1.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3fd08c3b0ddb346e3da2e3af82accd56a7ad1c2b80a3703b6d61b398049f8eef"
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
