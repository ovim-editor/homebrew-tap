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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.9/ovim-v0.1.9-aarch64-apple-darwin.tar.gz"
      sha256 "f1a4d50d33c556d720af96cd90af3ef64ba520147f5ed27919eab549b34bc44c"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.9/ovim-v0.1.9-x86_64-apple-darwin.tar.gz"
      sha256 "9db0ea8fba5517fdc04ee3ae07641ee74499ec28f3e3f72e016b3795275969e2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.9/ovim-v0.1.9-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0c4ec91ac8b2301fca1ab07f88421e3df2d929b853587aa6b09a647167f53763"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.9/ovim-v0.1.9-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a77bc987c3966e04ca3756bc12a1b3f2745b6a10675b5e952b31c679e21fe3cd"
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
