#!/usr/bin/env fish

function main
  # 「.」から始まるファイルのリンクを貼る
  link-dot-files

  # NvChadの設定ファイル
  if ! test -h {$HOME}/.config/nvim/lua/custom; and test -e {$HOME}/.config/nvim/lua/custom
    mv -T {$HOME}/.config/nvim/lua/custom {$HOME}/.config/nvim/lua/custom.bak
  end
  ln -fns {$HOME}/dotfiles/nvchad/custom {$HOME}/.config/nvim/lua/custom

  # Gitの設定をする
  configure-git
end


# 「.」から始まるファイルのリンクを貼る関数
function link-dot-files
  for file in .*
    # リンクを貼りたくないファイルは無視する
    if ignore {$file}
      continue
    end

    # まだリンクが貼られていなくてかつファイルが存在したらリネームして退避する
    if ! test -h {$HOME}/{$file}; and test -e {$HOME}/{$file}
      mv -T {$HOME}/{$file} {$HOME}/{$file}.bak
    end

    # リンクを貼る
    ln -fns {$HOME}/dotfiles/{$file} {$HOME}/{$file}
  end
end


# リンクを貼るかどうかを判定する関数
function ignore
  # リンクを貼りたくないものはここに入れておく
  set ignores '.' '..' '.DS_Store' '.git' '.gitignore' '.hyper.js' '.nyagos'

  for i in {$ignores}
    if test {$i} = {$argv}
      return 0
    end
  end
  return 1
end


# Gitの設定をする関数
function configure-git
  # ~/.gitconfigが存在しなかったら作成する
  # このファイルが存在しなかった場合、`git config --global`で設定したときに~/.config/git/configに書き込まれてしまう
  if ! test -e {$HOME}/.gitconfig
    touch {$HOME}/.gitconfig
  end

  # ユーザー名が設定されてなかったら対話形式で設定する
  if ! git config --global user.name > /dev/null 2>&1
    read -p'echo "ユーザー名に設定する文字列を入力してください> "' name
    git config --global user.name "$name"
  end
  # メールアドレスが設定されてなかったら対話形式で設定する
  if ! git config --global user.email > /dev/null 2>&1
    read -p'echo "ユーザーのメールアドレスに設定する文字列を入力してください> "' email
    git config --global user.email "$email"
  end

  # 文字コード
  # git diffしたときの文字コードをutf-8にする
  git config --global core.pager 'LESSCHARSET=utf-8 less -cmN'

  # 改行コード
  # プッシュするときは改行コードをLFに変換する
  # プルするときは変換しない
  git config --global core.autocrlf input
end


main
