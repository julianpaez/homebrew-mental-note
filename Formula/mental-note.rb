# Mental Note Homebrew Formula
# This formula installs the mental-note CLI tool
class MentalNote < Formula
  desc "Zero-dependency CLI for managing mental notes, tasks, and ideas with gamification"
  homepage "https://github.com/julianpaez/cli-mental-note"
  license "MIT"
  version "2.0.3"

  # Download URL - Points to tar.gz in this repository's releases/ folder
  # When hosting in GitHub, this will be:
  # https://github.com/YOUR_USERNAME/homebrew-mental-note/raw/main/releases/mental-note-v2.0.3-darwin-arm64.tar.gz
  url "https://github.com/julianpaez/homebrew-mental-note/raw/main/releases/mental-note-v2.0.3-darwin-arm64.tar.gz"
  sha256 "256e8b971d7ca2d862362086ba910bde85e1f566ac9bff4f125e087f6b240825"

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
      Mental Note CLI v2.0.3 has been installed!

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

      New in v2.0.3:
        • fix: date format

      For more information:
        https://github.com/julianpaez/cli-mental-note
    EOS
  end

  test do
    # Test that the binary runs and shows version
    assert_match "2.0.3", shell_output("#{bin}/mental-note --version")
    assert_match "2.0.3", shell_output("#{bin}/mn --version")

    # Test basic functionality
    system "#{bin}/mental-note", "version"
  end
end
