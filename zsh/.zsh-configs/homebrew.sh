# ==> Next steps:
# - Run these commands in your terminal to add Homebrew to your PATH:
#     echo >> /home/darksj1998/.zshrc
#     echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/darksj1998/.zshrc
#     eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
# - Install Homebrew's dependencies if you have sudo access:
#     sudo apt-get install build-essential
#   For more information, see:
#     https://docs.brew.sh/Homebrew-on-Linux

# The configuration for Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export HOMEBREW_CASK_OPTS="--appdir=~/Applications/Homebrew"
# export http_proxy="http://proxy.example.com:8080"
# export https_proxy="http://proxy.example.com:8080"
# export no_proxy="localhost,"
