class FastpaperCli < Formula
  desc "CLI tool for searching, downloading and reading academic papers"
  homepage "https://github.com/zhangyee/fastpaper-cli"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.1.0/fastpaper-cli-aarch64-apple-darwin.tar.xz"
      sha256 "9e57f6adf0ffee1362b7c76df2d2a3a68ba72bc677b02078ab5d655eed9f0ff7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.1.0/fastpaper-cli-x86_64-apple-darwin.tar.xz"
      sha256 "e386a0dbe40a2fc3cda17fe14e50b5dff21797f5dd58cc02b4dce0a82b747174"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.1.0/fastpaper-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cd76f883775ab62a16d079696c1df91de7d2ce70f50c129c1da00ae77e310728"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.1.0/fastpaper-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "af5140b9fb428d1d7090bf6cb077b84681823130a7e6fd323c8a99a028d8f30e"
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
