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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.20/ovim-v0.1.20-aarch64-apple-darwin.tar.gz"
      sha256 "eb469be4d900142aadabdd4c3858541c5c20ee3f1f9e3e1aa991743a5657ebaa"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.20/ovim-v0.1.20-x86_64-apple-darwin.tar.gz"
      sha256 "8c68dff8d28f552220dcd93287b33a2347671c9eafeca50250da9de94517745e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.20/ovim-v0.1.20-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fb226a160eb0c9a0a719741139b3859e8de0f413c9d16d640153cc23707df4f5"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.20/ovim-v0.1.20-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b84009b8bff2d2e86e669cd48e8f324ad297c694c438fe7dd0dc76c80058290e"
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
