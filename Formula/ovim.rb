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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.9.0/ovim-v1.9.0-aarch64-apple-darwin.tar.gz"
      sha256 "476443be6020d710c08543773bc6c96c0ac469b136a1fd3ea3b5a2f34a3d8eaf"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.9.0/ovim-v1.9.0-x86_64-apple-darwin.tar.gz"
      sha256 "a7c991b3f15bf3c57f449480321e698a7b15ded202dc4d144f7ce4bc313bcea2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.9.0/ovim-v1.9.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f00c2972fd541b24c61a5ab5179669cef8ceea6b6e00cce94bb549c1914cfef2"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.9.0/ovim-v1.9.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4b226fd1bf0c12dfabe2aabd153997fb96219a284e4fb03db407f19342cdae86"
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
