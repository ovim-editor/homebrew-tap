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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.22/ovim-v0.1.22-aarch64-apple-darwin.tar.gz"
      sha256 "f413fbe89a53a1e09749ad7addf305660071a7606185148723afeda4b94f3b19"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.22/ovim-v0.1.22-x86_64-apple-darwin.tar.gz"
      sha256 "dd2a8ac22eaf1726032ad5cfdc4872c16362f53fe1c01ba1491676090a680666"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.22/ovim-v0.1.22-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f36b001c270ee7656e9e0c84f9f33c8d27d294e0922e7620b2862d31320afad7"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.22/ovim-v0.1.22-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2d4f745ae75bb9deb7867733ac7021ad8c3ac2ad694a6f50f4d0da1c9a8d667f"
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
