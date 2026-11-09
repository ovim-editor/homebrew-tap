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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.6.0/ovim-v1.6.0-aarch64-apple-darwin.tar.gz"
      sha256 "b09aa0077880ea2d5fece3e25e1c27e57e543b685ea3d25205988d990d57fafd"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.6.0/ovim-v1.6.0-x86_64-apple-darwin.tar.gz"
      sha256 "f67bd0e6eb7bdab1b6e6a6017b778ef1018bb8253b3bdf224e1f2c8090a7cd17"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.6.0/ovim-v1.6.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "494ed80fc9dc9dee3cc9bb024a9672a11b80acabc75f7cbf45274caba91abbc1"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.6.0/ovim-v1.6.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fdb26b0e39e02359797bbf71f2f1dfb6823b2db54fc317af02d2d101c3d329c3"
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
