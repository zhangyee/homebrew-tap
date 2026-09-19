class FastpaperCli < Formula
  desc "CLI tool for searching, downloading and reading academic papers"
  homepage "https://github.com/zhangyee/fastpaper-cli"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.9.0/fastpaper-cli-aarch64-apple-darwin.tar.xz"
      sha256 "70053a920e13cbcbf0c154ae001a16fc39d0757d50c3ddf901f1013defee8da5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.9.0/fastpaper-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a3314d563f63b54ecbf61325eaf1f2a8d18a71776c27932dacc8a425184ada97"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.9.0/fastpaper-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "06102359704549d8d1a5ff8249a3ac1d72a409d21f0c87efbd628af0c621c76a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.9.0/fastpaper-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5cce6e9a8bed5246bedbfa0dc01f9d822d82ebd58bbdc91f9384befc952f8667"
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
