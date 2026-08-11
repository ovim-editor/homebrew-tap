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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.3/ovim-v1.2.3-aarch64-apple-darwin.tar.gz"
      sha256 "d8e8eb8eab83542832c8092dc4a2632baf1461d7e857445987259e426573970d"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.3/ovim-v1.2.3-x86_64-apple-darwin.tar.gz"
      sha256 "a17062ca5c5377c7dc4b14c12d3a946fe1427c502a5ca0188c9f597d42a9ae0a"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.3/ovim-v1.2.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "46e66b7fddf8d32c6f05a3b8cff28efbaf51ed673cb8c0fd795fb7e4e8a024a6"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.3/ovim-v1.2.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "8c1b9320e9e2df4915ee56da0a6af4703d4af7008beff9df5bd5ee2da3d28e02"
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
