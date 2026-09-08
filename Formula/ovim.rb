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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.3.0/ovim-v1.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "957c74c2b7ced5c0b65e101850a1be51816e564f20364f9ceb36e222329db390"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.3.0/ovim-v1.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "651aa9d826ae3d9ce4dfb9dcecef4a4988e2c87c0c8e4d41495e76c01e19e0b2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.3.0/ovim-v1.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d87a01a122c4486d6fec724b16cf8c524afe44a8a4fdc8a3c9ebb59408c219f6"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.3.0/ovim-v1.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "07ca4c15f77c6900b507540984fc1076cfca4ad6c6e8620897428dcc18d06522"
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
