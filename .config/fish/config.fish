# 文字コードをUTF-8にする
# set -x LC_ALL ja_JP.UTF-8


# linuxbrewの設定
if [ -d /home/linuxbrew/.linuxbrew ]
  set -x HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew"
  set -x HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar"
  set -x HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew"
  set -x HOMEBREW_SHELLENV_PREFIX "/home/linuxbrew/.linuxbrew"
  set -x PATH {$PATH} "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin"
  set -x MANPATH {$MANPATH} "/home/linuxbrew/.linuxbrew/share/man"
  set -x INFOPATH {$INFOPATH} "/home/linuxbrew/.linuxbrew/share/info"
end


if ! [ -z {$SSH_CONNECTION} ]
  # SSH接続の場合
  if type -q tmux
    if [ -z {$TMUX} ]
      # tmuxのセッション外だったら
      if tmux list-sessions > /dev/null 2>&1
        # すでにセッションが存在したらそれにアタッチする
        exec tmux -u attach
      else
        # セッションが存在しなかったら新しく作ってアタッチする
        exec tmux -u
      end
    end
  end
end


# パスの設定
if [ -d {$HOME}/.local/bin ]
  set -x PATH {$PATH} {$HOME}/.local/bin
end

# Java
if [ -d {$HOME}/.sdkman/candidates/java/current/bin ]
  set -x PATH {$PATH} {$HOME}/.sdkman/candidates/java/current/bin
end

# Kotlin
if [ -d {$HOME}/.sdkman/candidates/kotlin/current/bin ]
  set -x PATH {$PATH} {$HOME}/.sdkman/candidates/kotlin/current/bin
end

# Rust
if [ -d {$HOME}/.cargo/bin ]
  set -x PATH {$PATH} {$HOME}/.cargo/bin
end

# Nim
if [ -d {$HOME}/.nimble/bin ]
  set -x PATH {$PATH} {$HOME}/.nimble/bin
end

# Go
set -x GOPATH {$HOME}/.go
if [ -n {$GOPATH} ]
  set -x PATH {$PATH} {$GOPATH}/bin
end

# Node.js
if [ -n {$HOME}/.volta/bin ]
  set -x PATH {$PATH} {$HOME}/.volta/bin
end
if [ -n {$HOME}/.volta ]
  set -x VOLTA_HOME {$HOME}/.volta
end

# Python
set -x PYENV_ROOT {$HOME}/.pyenv
if [ -n {$PYENV_ROOT}/bin ]
  set -x PATH {$PATH} {$PYENV_ROOT}/bin
end
if type pyenv > /dev/null 2>&1
  pyenv init - | source
end


# neovimに必要な設定
set -x XDG_CONFIG_HOME {$HOME}/.config
set -x XDG_CACHE_HOME {$HOME}/.cache


# デフォルトのエディタの設定
# vim、neovim、viの順番でインストールされているか確認して、されていたらそれに設定する
if type -q vim
  set -x EDITOR vim
  set -x VISUAL vim
else if type -q vi
  set -x EDITOR vi
  set -x VISUAL vi
else if type -q nvim
  set -x EDITOR nvim
  set -x VISUAL nvim
else
  echo 'vimもnvimもviもありませんでした'
end


# HomebrewのAnalyticsを停止
set -x HOMEBREW_NO_ANALYTICS 1
if [ -x /opt/homebrew/bin/brew ]
  eval (/opt/homebrew/bin/brew shellenv)
end


# エイリアスの設定
alias less "less -cmN"
alias del "delete"
alias arichu 'arisu'


# Starshipの設定
if type -q starship
  starship init fish | source
end


# OS毎の設定
switch (uname) # なぜかlinterに引っかかる
  case Darwin # Macのとき
    alias safari "open -a /Applications/Safari.app"
    alias chrome "open -a /Applications/Google\ Chrome.app"
    alias firefox "open -a /Applications/Firefox.app"
    alias ls "ls -FG"
    alias la "ls -aFG"
    alias ll "ls -FGl"
  case Linux # Linuxのとき
    alias ls "ls -F --color=auto"
    alias la "ls -aF --color=auto"
    alias ll "ls -Fl --color=auto"
end

# Windows Subsystem for Linuxのとき
if uname -r | grep -i Microsoft > /dev/null 2>&1
  alias firefox "/mnt/c/Program\ Files/Mozilla\ Firefox/firefox.exe"
end


# Starshipの設定
if type -q starship
  starship init fish | source
end
