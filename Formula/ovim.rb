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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.6/ovim-v1.2.6-aarch64-apple-darwin.tar.gz"
      sha256 "263c24187df746f0a99904f82eee306aee4c277614b7df8700161926999d11a8"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.6/ovim-v1.2.6-x86_64-apple-darwin.tar.gz"
      sha256 "4512fb3b87b45ecbc35f2ee81391200b0bfdce9aed73f67e13770812901c40d3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.6/ovim-v1.2.6-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "766addc054851e85577d578d9293f5ac2e8195c75449becd72d78d3184cd7cc0"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.2.6/ovim-v1.2.6-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "450fc0d488295ac1da1bbce2dc0fb5ae438555276b3a022c4389bdcfc19a9899"
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
