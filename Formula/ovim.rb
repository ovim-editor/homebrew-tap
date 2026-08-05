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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.21/ovim-v0.1.21-aarch64-apple-darwin.tar.gz"
      sha256 "333b9a51af85f12d7709cc94b44d6766921ebeb013d3bcf5650d10003cd013b8"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.21/ovim-v0.1.21-x86_64-apple-darwin.tar.gz"
      sha256 "165c6567a2fe7348ea87743d35ab626d018ff241b89a9a573472d4daa4d35728"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.21/ovim-v0.1.21-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3990879dce1bee6a8ddce4ece570b7525c73f523e70d2cc1c8963dc8ced8c21a"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.21/ovim-v0.1.21-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2c6251a112027b073a5ec1e5c5364d819fb41329f41492d283ed64194796d60d"
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
