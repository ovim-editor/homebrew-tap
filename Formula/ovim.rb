class Ovim < Formula
  desc "Fast terminal editor with Vim keybindings, Lua, LSP, and AI"
  homepage "https://github.com/ovim-editor/ovim"
  url "https://github.com/ovim-editor/ovim/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "0893a2ab33068b88b0fa438b2d659c43225ced7c6630bf8651442bddb4e00caa"
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
