class FastpaperCli < Formula
  desc "CLI tool for searching, downloading and reading academic papers"
  homepage "https://github.com/zhangyee/fastpaper-cli"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.7.0/fastpaper-cli-aarch64-apple-darwin.tar.xz"
      sha256 "84d358d618441b47cd61949fee35512731366574d3d38b8dd3f03c99d0756e58"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.7.0/fastpaper-cli-x86_64-apple-darwin.tar.xz"
      sha256 "1fe9cfb6b6b07badb47ea03f279d7bf39448a0051719afea76fbf58fb93409d3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.7.0/fastpaper-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "52c53d4c8381a2787239060c23ea080252ca9888addce5500640c060e0403a56"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.7.0/fastpaper-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1de186108ddf4927daf003e9ec585afbac5ab08e21d5ccc1f76684ef6942615c"
    end
  end
  license "GPL-3.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "fastpaper"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "fastpaper"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "fastpaper"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fastpaper"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
