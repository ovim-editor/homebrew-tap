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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.14/ovim-v0.1.14-aarch64-apple-darwin.tar.gz"
      sha256 "ec18dd66e484e2b2938090dbd456205cdde4a2c18d01dbca37f535e34600e5b2"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.14/ovim-v0.1.14-x86_64-apple-darwin.tar.gz"
      sha256 "2ddbeae3a6284b92df34d95ec73843207cb967e487c35d452c77562264525ab6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.14/ovim-v0.1.14-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "efe3834d47667ac1222b278bcc02011833fc34a4a421f4effdfab6a1954c16ed"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.14/ovim-v0.1.14-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8a3570b23645ae27487086e963b8f005b64606df280373d48902ff46b0823f51"
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
