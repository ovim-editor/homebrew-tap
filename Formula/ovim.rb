class Ovim < Formula
  desc "Oxidized Vim — snappy, batteries-included terminal editor with Vim keybindings, Lua config, LSP, and AI"
  homepage "https://github.com/ovim-editor/ovim"
  url "https://github.com/ovim-editor/ovim/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "13a852630088560c60abead3e8a01026abf7988694e5438a7524bdba2faef287"
  license "MIT"
  head "https://github.com/ovim-editor/ovim.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "ovim")
  end

  test do
    assert_match "Oxidized Vim", shell_output("#{bin}/ovim --help")
  end
end
