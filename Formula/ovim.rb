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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.19/ovim-v0.1.19-aarch64-apple-darwin.tar.gz"
      sha256 "d488f4e0c540957599bbefa4070fd3466dc558b176e21edc5242f794a13545af"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.19/ovim-v0.1.19-x86_64-apple-darwin.tar.gz"
      sha256 "80d1d89f0ee81cd4ba4bda463f4ca3e7873a32dd7e285dba76f4b1860d451cab"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.19/ovim-v0.1.19-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "83dceed2aa3afc1594bfde5a219ed7657aa79442d42be80e7c0ba40cd2e3783f"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.19/ovim-v0.1.19-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "df8f2bbe0fafe319033df338a782263522ac60bbf74ed5ecfa732051aab8aa66"
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
