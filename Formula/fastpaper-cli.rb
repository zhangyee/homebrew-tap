class FastpaperCli < Formula
  desc "CLI tool for searching, downloading and reading academic papers"
  homepage "https://github.com/zhangyee/fastpaper-cli"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.5.0/fastpaper-cli-aarch64-apple-darwin.tar.xz"
      sha256 "77a0f6a03fd80002797e4fd1cad9f798c8f60b1bc53989ef287df31b9cb02155"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.5.0/fastpaper-cli-x86_64-apple-darwin.tar.xz"
      sha256 "9d410909ef0752a9bc03024a43ca2a7093dd4ba3ac717fb6972c7f095261cb3b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.5.0/fastpaper-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2200eb3a9f9bbc04680dfea52005a1481ba9a96116b2ee9d207e9276e1b67852"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.5.0/fastpaper-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fd24140c579539fce977541db8be8fc0e48bc2911c14339ea870a5f9cc178f07"
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
