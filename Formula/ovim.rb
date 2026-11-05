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
      url "https://github.com/ovim-editor/ovim/releases/download/v1.5.1/ovim-v1.5.1-aarch64-apple-darwin.tar.gz"
      sha256 "8f15b45c3ed698ef93ce3c2d3cd35d5f09dddc28f47399322efb2a21c6ca2f56"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.5.1/ovim-v1.5.1-x86_64-apple-darwin.tar.gz"
      sha256 "85423322cc87a5f20cf015fefff528f7185011949ee600b504a930813d635d60"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v1.5.1/ovim-v1.5.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "45aa6c23707c53bbb4219ac183fc8c4cd179f958ee5c2b67eb6166f6a09da261"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v1.5.1/ovim-v1.5.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a4e658259f2190d03f886be86df5322979afef1cc8f8ae3087a80510679f5d22"
    end
  end

  def install
    if build.head?
      system "cargo", "install", *std_cargo_args(path: "ovim"),
             "--no-default-features", "--features", "lua,vendored", "--bin", "ovim"
    else
      bin.install "ovim"
    end
  end

  test do
    assert_match "Oxidized Vim", shell_output("#{bin}/ovim --help")
  end
end
