class FastpaperCli < Formula
  desc "CLI tool for searching, downloading and reading academic papers"
  homepage "https://github.com/zhangyee/fastpaper-cli"
  version "0.8.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.8.1/fastpaper-cli-aarch64-apple-darwin.tar.xz"
      sha256 "5eb822f670993637254063faa9f96574d4e7f5d0bec87d855069f718ca5965b2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.8.1/fastpaper-cli-x86_64-apple-darwin.tar.xz"
      sha256 "b57d04d1022052536d4dff8d6e1a22e99c82fdb1b00b3dbb4206577901ab68be"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.8.1/fastpaper-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "36ce390e528d9c4e79b312992006fb6e91760e5809af7a96d3ae865b3cc2261c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.8.1/fastpaper-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a9fd520ac27fd9bb1a0aee096333a14cdc7b2f24834205f77200f69665b88258"
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
