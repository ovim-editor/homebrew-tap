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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.1.0/ovim-v1.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "e689356ed851b36435975077e88d757bfb6ac59c299325a02652a7bd0f8567c3"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.1.0/ovim-v1.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "14f6fa97fb1cb8afc5625bdedcf95ac28c46f522f70fd5549222c52d734fc963"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.1.0/ovim-v1.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "04a258f27a1ceb2cd197e7abfb5be3c680b49efd5889312e103ac856925eb3c6"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.1.0/ovim-v1.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "783a1fb8b7cf94a9f4b23b6efc821cc7ba455a0863ba61fae72a08102a18699a"
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
