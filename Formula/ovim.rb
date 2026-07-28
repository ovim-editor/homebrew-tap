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
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.13/ovim-v0.1.13-aarch64-apple-darwin.tar.gz"
      sha256 "29617023d7185c8f16284fa0123f319c7af2c18b0b61fe9ad61747b434a957ec"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.13/ovim-v0.1.13-x86_64-apple-darwin.tar.gz"
      sha256 "b2ef8d3fdf5360d01a3645d61aea9c6ebc64a66a5efc673d10abaf3835be54af"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.13/ovim-v0.1.13-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f8a4c6d3c1b3f7b6fc20eed5f21d46e375b2c498c5978dc9afd73b206c79d367"
    else
      url "https://github.com/ovim-editor/ovim/releases/download/v0.1.13/ovim-v0.1.13-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "313c7692e33048307c13b0b7b7e52149958ee6a9861c19ca97fea464e12335eb"
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
