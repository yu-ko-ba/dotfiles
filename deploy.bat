@echo off


rem �V���{���b�N�����N��\��
mklink %homepath%\_vimrc %homepath%\dotfiles\.vimrc
mklink /D %homepath%\.config %homepath%\dotfiles\.config
mklink /D %localappdata%\nvim\lua\custom %homepath%\dotfiles\nvchad\custom
mklink %appdata%\Hyper\.hyper.js %homepath%\dotfiles\.hyper.js
mklink %homepath%\.nyagos %homepath%\dotfiles\.nyagos


rem Git�̐ݒ������
rem %homepath%\.gitconfig�����݂��Ȃ�������쐬����
rem ���̃t�@�C�������݂��Ȃ������ꍇ�A`git config --global`�Őݒ肵���Ƃ���%homepath%\.config\git\config�ɏ������܂�Ă��܂�
if not exist %homepath%\.gitconfig type nul >> %homepath%\.gitconfig

rem ���s�R�[�h
rem �v�b�V������Ƃ���LF�ɕϊ�����
rem �v������Ƃ���CRLF�ɕϊ�����
git config --global core.autocrlf true

rem SSH�̌��J�����w�肷��
git config --global user.signingkey %homepath%\.ssh\id_ed25519.pub


pause
