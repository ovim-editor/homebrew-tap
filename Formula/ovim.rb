class Ovim < Formula
  desc "Fast terminal editor with Vim keybindings, Lua, LSP, and AI"
  homepage "https://github.com/ovim-editor/ovim"
  version "0.1.8"
  license "MIT"

  head do
    url "https://github.com/ovim-editor/ovim.git", branch: "main"
    depends_on "rust" => :build
  end

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.8/ovim-v0.1.8-aarch64-apple-darwin.tar.gz"
      sha256 "4446b0504ae99fd66dd201bae88fe01b98899a7dbda5db69e5e84a39763a807e"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.8/ovim-v0.1.8-x86_64-apple-darwin.tar.gz"
      sha256 "3cf772f96843bea93401ca1f17fa4dbcfe3bc235c9d36b7f8c8f15011059b4bb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.8/ovim-v0.1.8-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "826e8d7093ca70982398953de8e1b4070b775f5cbd7cfdcd6964aba0d4557930"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.8/ovim-v0.1.8-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b5546ffb9a9d1085c7399a9e1dc361be1178b21334c6f65ff13c367476469b9f"
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
