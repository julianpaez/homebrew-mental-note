# Mental Note Homebrew Formula
# This formula installs the mental-note CLI tool
class MentalNote < Formula
  desc "Zero-dependency CLI for managing mental notes, tasks, and ideas with gamification"
  homepage "https://github.com/julianpaez/cli-mental-note"
  license "MIT"
  version "1.9.0"

  # Download URL - Points to tar.gz in this repository's releases/ folder
  # When hosting in GitHub, this will be:
  # https://github.com/YOUR_USERNAME/homebrew-mental-note/raw/main/releases/mental-note-v1.9.0-darwin-arm64.tar.gz
  url "https://github.com/julianpaez/homebrew-mental-note/raw/main/releases/mental-note-v1.9.0-darwin-arm64.tar.gz"
  sha256 "bede0b81446fb68849af8cb211bf32ee8569314b82ce1afe57984672ae151ac3"

  # System requirements
  depends_on :macos
  depends_on arch: :arm64

  def install
    # Install the main binary
    bin.install "mental-note"

    # Create symlink for short alias
    bin.install_symlink "mental-note" => "mn"

    # Install documentation files
    doc.install "README.md" if File.exist?("README.md")
    doc.install "QUICKSTART.md" if File.exist?("QUICKSTART.md")
  end

  def caveats
    <<~EOS
      Mental Note CLI v1.9.0 has been installed!

      You can use either command:
        mental-note --help
        mn --help

      Quick start:
        mn add do "My first task" --tags work --due tomorrow
        mn list
        mn done 1
        mn profile          # View gamification stats
        mn badges           # See achievements
        mn version

      New in v1.9.0:
        • Short names for commands

      For more information:
        https://github.com/julianpaez/cli-mental-note
    EOS
  end

  test do
    # Test that the binary runs and shows version
    assert_match "1.9.0", shell_output("#{bin}/mental-note --version")
    assert_match "1.9.0", shell_output("#{bin}/mn --version")

    # Test basic functionality
    system "#{bin}/mental-note", "version"
  end
end
