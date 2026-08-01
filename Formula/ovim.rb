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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.16/ovim-v0.1.16-aarch64-apple-darwin.tar.gz"
      sha256 "f746befb8969a3d221aa7aaa4bfa0ca29758f15497abec01e95ec7398f996b89"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.16/ovim-v0.1.16-x86_64-apple-darwin.tar.gz"
      sha256 "9ac8e4f44756fade96aa65f8417bf126cdc2dc6bc72a72b443c66afbaeafa514"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.16/ovim-v0.1.16-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d1e5e8f4927cb203ddd6c7e9e022f2358b178f097a58be1193e607eccc1e1a2c"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.16/ovim-v0.1.16-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ab5f20d5638bf72caf002deb570931c2aac779a95942cfdb9110e45cd8a6ca0d"
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
