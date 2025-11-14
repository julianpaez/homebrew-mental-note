# Homebrew Tap for Mental Note CLI

Official Homebrew tap for Mental Note CLI - a zero-dependency CLI tool for managing mental notes, tasks, and ideas.

## Installation

### Install via Homebrew

```bash
# Add the tap
brew tap julianpaez/mental-note

# Install mental-note
brew install mental-note

# Verify installation
mental-note --version
mn --version
```

### One-Line Installation

```bash
brew install julianpaez/mental-note/mental-note
```

## Usage

Once installed, you can use either the full command or the short alias:

```bash
# Add a task
mn add do "Call dentist"

# List all notes
mn list

# Show help
mn --help

# Check version
mn version
```

## Updating

```bash
# Update Homebrew formulae
brew update

# Upgrade mental-note to latest version
brew upgrade mental-note
```

## Uninstallation

```bash
brew uninstall mental-note
brew untap julianpaez/mental-note
```

## Features

- **Zero Dependencies**: Uses only Python standard library
- **Lightweight**: ~7MB binary
- **Fast**: Instant startup and response
- **Multiple Actions**: remember, do, contemplate, forget, ignore, stick
- **Advanced Features**:
  - Task completion tracking
  - Tag-based organization
  - Timeline visualization
  - Analytics dashboard
  - Due date reminders
  - Archive functionality
  - Export/import backups
  - Notification System

## System Requirements

- macOS (Apple Silicon - ARM64)
- macOS 11.0 (Big Sur) or later

## Support
- **Email**: dev@julianpaez.com

## License

MIT License - Copyright (c) 2025 Julian Paez

---
