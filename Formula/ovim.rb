class Ovim < Formula
  desc "Fast terminal editor with Vim keybindings, Lua, LSP, and AI"
  homepage "https://github.com/ovim-editor/ovim"
  url "https://github.com/ovim-editor/ovim/archive/refs/tags/v0.1.5.tar.gz"
  sha256 "f1a132df032715f5c39d6852f8f57a11d155c907909efcd3b0436b95e2e7b7f2"
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
