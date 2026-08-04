class FastpaperCli < Formula
  desc "CLI tool for searching, downloading and reading academic papers"
  homepage "https://github.com/zhangyee/fastpaper-cli"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.3.2/fastpaper-cli-aarch64-apple-darwin.tar.xz"
      sha256 "fb1174927fa10708d5d746861adf1594ee9b73530570d3489571125b36316ac8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.3.2/fastpaper-cli-x86_64-apple-darwin.tar.xz"
      sha256 "9a78a98722fe0409f8c0bc6f0ef266d30fd1ce3e08ca30427ebf22017a063be7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.3.2/fastpaper-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1e2652d5b3ca7845950c3d4597e8fa875752b4e10b8f696ae4b44aebd4b593ff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.3.2/fastpaper-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cd4940e60e35ca2ecee0c3cbc06b1f7318c2821038bed4bd54688b9939305d46"
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
