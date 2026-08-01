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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.17/ovim-v0.1.17-aarch64-apple-darwin.tar.gz"
      sha256 "a01a2f6ca3a80cc6974ac109f3f313782ba60d19a7f6801dc6ac860e26c6f9c3"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.17/ovim-v0.1.17-x86_64-apple-darwin.tar.gz"
      sha256 "d7f5f9a836657b2aed9dacae0143002c8b9b9fd36564e46c0cb4bc65a72af5b1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.17/ovim-v0.1.17-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8addfa8a2ab2bc3df0a75efc5efefea4e989d31b72638bb54accebf0dc6dabfd"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.17/ovim-v0.1.17-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d8a97639cb2b3eb72f2517d483e41d1d4b8dcdeb8166f96d7f932acd0038c502"
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
