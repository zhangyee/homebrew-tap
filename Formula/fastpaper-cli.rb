class FastpaperCli < Formula
  desc "CLI tool for searching, downloading and reading academic papers"
  homepage "https://github.com/zhangyee/fastpaper-cli"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.1.1/fastpaper-cli-aarch64-apple-darwin.tar.xz"
      sha256 "ef1a00c6745ab866d34aa864ba300a9c3782adc788062203fb18c30904f51dd7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.1.1/fastpaper-cli-x86_64-apple-darwin.tar.xz"
      sha256 "cb679b6e7767ee26d4978d9f0f963f6c023252976b1e5031e291531be9f55cc9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.1.1/fastpaper-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2375703a9b1038157be48d118d7f953baa149e2304a3b5dd52645004eb42a95b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.1.1/fastpaper-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8ffe64b0037c9a3b941ccbe197a93199fd53c78540b95f24d09acaf9b19df132"
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
