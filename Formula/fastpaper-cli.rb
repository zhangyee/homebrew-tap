class FastpaperCli < Formula
  desc "CLI tool for searching, downloading and reading academic papers"
  homepage "https://github.com/zhangyee/fastpaper-cli"
  version "0.6.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.6.0/fastpaper-cli-aarch64-apple-darwin.tar.xz"
      sha256 "cdcb81123e6f097d9ce3f114a1d146c71a1479a46d3c5c19693ada9d03f95394"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.6.0/fastpaper-cli-x86_64-apple-darwin.tar.xz"
      sha256 "413b5e334a0f54adca4ce9c0ae9e340f5f4c59be8c71aed8d4bde3a48147051c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.6.0/fastpaper-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ddf5dac4f647e521da6ec89039cc3c0284e171eb63758465a78307207832951a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.6.0/fastpaper-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7d99b324da058afe294f6e5e37f378333ccbe0a90aa8b0fcb19ba7de62e799b1"
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
