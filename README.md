# Marc’s dotfiles

Inspired by...
    - Mathias Bynens [dotfiles](https://github.com/mathiasbynens/dotfiles)
    - Dries Vints [dotfiles](https://github.com/driesvints/dotfiles)

## Installation

```bash
# 1. Update macOS to the latest version with the App Store

# 2. Install macOS Command Line Tools by running xcode-select --install
xcode-select --install

# 3. Copy your public and private SSH keys to ~/.ssh and make sure they're set to 600

# 4. Clone this repo to ~/.dotfiles
cd ~; git clone https://github.com/marcaube/dotfiles.git .dotfiles

# 5. Run install.sh to start the installation
sh .dotfiles/install.sh

# 6. Restore preferences by running mackup restore
mackup restore

# 7. Restart your computer to finalize the process
shutdown -r
```
