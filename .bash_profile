linuxbrew_path="/home/linuxbrew/.linuxbrew/bin/brew"
if [ -e ${linuxbrew_path} ]; then
    eval "$(${linuxbrew_path} shellenv)"
fi

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
. "$HOME/.cargo/env"
