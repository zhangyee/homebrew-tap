class FastpaperCli < Formula
  desc "CLI tool for searching, downloading and reading academic papers"
  homepage "https://github.com/zhangyee/fastpaper-cli"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.2.1/fastpaper-cli-aarch64-apple-darwin.tar.xz"
      sha256 "ed0f4c887b1da56a0d6ad288e9342468272ac32f2da5932a00baf9c154602405"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.2.1/fastpaper-cli-x86_64-apple-darwin.tar.xz"
      sha256 "6386f8a42ff3ccf08e659e4b88a228bb3e1af700f3f912f19e612332bdce247f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.2.1/fastpaper-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "110bdf7d750ca2e85ac8b3e3a004c9055cbb336f3b1e1d7bdf8442f6ea079950"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.2.1/fastpaper-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "50552e3f08a7483800921cfe7bd9ffdd877ad17d9980084f78d911e21dd838c6"
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
    bin.install "fastpaper" if OS.mac? && Hardware::CPU.arm?
    bin.install "fastpaper" if OS.mac? && Hardware::CPU.intel?
    bin.install "fastpaper" if OS.linux? && Hardware::CPU.arm?
    bin.install "fastpaper" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
