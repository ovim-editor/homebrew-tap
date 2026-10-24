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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.5.0/ovim-v1.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "e082b85a00132600b2dccdc116022ab9def3d9fbe8c4c4c5d7031f8358707025"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.5.0/ovim-v1.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "8de0328708971b49dd96c4b9709401f475ad88945dc98fa86467bf505f3f2cd8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.5.0/ovim-v1.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "74e2170582be4a8ad7b52b73102ff3ea60a3f96e6d571d91108f39cd9c737d3a"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.5.0/ovim-v1.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a6a4289bf881072b9c7e7ac36e2a0eb26c18b519850c86d2a9bd0943f816aaee"
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
