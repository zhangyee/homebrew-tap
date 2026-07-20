class FastpaperCli < Formula
  desc "CLI tool for searching, downloading and reading academic papers"
  homepage "https://github.com/zhangyee/fastpaper-cli"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.2.0/fastpaper-cli-aarch64-apple-darwin.tar.xz"
      sha256 "384005a4a2082bdc895054f101246b80c2a36fd7b28842fa29361ad1c517112f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.2.0/fastpaper-cli-x86_64-apple-darwin.tar.xz"
      sha256 "de6c3de219690a8441447d787180a845c49950e793e1258de57631bde8fb7077"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.2.0/fastpaper-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "32d5e0d4c8d16044804be32b42b976f1fdaac6597b49cbc460d82f40ebfd8c10"
    end
    if Hardware::CPU.intel?
      url "https://github.com/zhangyee/fastpaper-cli/releases/download/v0.2.0/fastpaper-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "19919f17526a7a8aef78ee99366421b7573b840b88d6dc32e026cc6bdf507c16"
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
