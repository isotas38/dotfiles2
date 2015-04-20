# LANG
export LANG='en_US.UTF-8'

# 色を使用出来るようにする
autoload -Uz colors
colors

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

fpath=(${HOME}/dotfiles/zsh/functions(N-/) ${fpath})
# zsh-completions
fpath=($HOME/dotfiles/zsh/zsh-completions/src $fpath)

# 補完機能を有効にする
autoload -Uz compinit
compinit

# プロンプト
PROMPT=${SSH_TTY:+"%F{red}%n%f@%F{yellow}%m%f "}%F{cyan}%~%f" %B%F{red}❯%F{yellow}❯%F{green}❯%f%b "

#
# Options
#
#
# Directory
#
# 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt AUTO_CD
# cd -[tab]を押すとdir list を表示
setopt AUTO_PUSHD
# ディレクトリスタックに同じディレクトリを追加しないようになる
setopt PUSHD_IGNORE_DUPS
# Do not print the directory stack after pushd or popd.
setopt PUSHD_SILENT
# 引数なしのpushdをpushd $HOMEへ
setopt PUSHD_TO_HOME
# 絶対パスが入った変数をディレクトリとして扱う
setopt CDABLE_VARS
# Auto add variable-stored paths to ~ list.
setopt AUTO_NAME_DIRS
# 複数リダイレクト
setopt MULTIOS
# 高機能なワイルドカード展開を使用する
setopt EXTENDED_GLOB
# あえて上書きしたい場合は >| か >! を使う
unsetopt CLOBBER

#
# History
#
# !を使ったヒストリ展開を行う
setopt BANG_HIST
# Write the history file in the ':start:elapsed;command' format.
setopt EXTENDED_HISTORY
# Write to the history file immediately, not when the shell exits.
setopt INC_APPEND_HISTORY
# Share history between all sessions.
setopt SHARE_HISTORY
# Expire a duplicate event first when trimming history.
setopt HIST_EXPIRE_DUPS_FIRST
# Do not record an event that was just recorded again.
setopt HIST_IGNORE_DUPS
# Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_ALL_DUPS
# Do not display a previously found event.
setopt HIST_FIND_NO_DUPS
# Do not record an event starting with a space.
setopt HIST_IGNORE_SPACE
# Do not write a duplicate event to the history file.
setopt HIST_SAVE_NO_DUPS
# Do not execute immediately upon history expansion.
setopt HIST_VERIFY
# Beep when accessing non-existent history.
setopt HIST_BEEP

#
# ENVIRONMENT
#
# Allow brace character class list expansion.
setopt BRACE_CCL
# 複数の文字の組み合わせをサポートするバイトモード
setopt COMBINING_CHARS
# '(シングルクォート)内でシングルをつなげて' を表現できる
setopt RC_QUOTES

#
# Jobs
#
# 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt LONG_LIST_JOBS
# サスペンド(Ctrl+Z)中のプロセスと同じコマンド名を実行した場合はリジューム
setopt AUTO_RESUME
# バックグラウンドジョブ状態の即時報告
setopt NOTIFY
# 全てのバックグラウンドジョブを低優先度で実行する
unsetopt BG_NICE
# Don't kill jobs on shell exit.
unsetopt HUP
# Don't report on jobs when shell exit.
unsetopt CHECK_JOBS

#
# Completion
#
# Complete from both ends of a word.
setopt COMPLETE_IN_WORD
# Move cursor to the end of a completed word.
setopt ALWAYS_TO_END
# Perform path search even on command names with slashes.
setopt PATH_DIRS
# Show completion menu on a succesive tab press.
setopt AUTO_MENU
# Automatically list choices on ambiguous completion.
setopt AUTO_LIST
# If completed parameter is a directory, add a trailing slash.
setopt AUTO_PARAM_SLASH
#エイリアスも補完対象に設定
setopt COMPLETE_ALIASES
# Do not autoselect the first completion entry.
unsetopt MENU_COMPLETE
# Disable start/stop characters in shell editor.
unsetopt FLOW_CONTROL
# No beep on error in line editor.
unsetopt BEEP
# No beep sound when complete list displayed
unsetopt LIST_BEEP

#
# Key
#
# emacs keybind
bindkey -e
# historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
# reverse menu completion binded to Shift-Tab
bindkey -M emacs "\E[Z" reverse-menu-complete
# Edit command in an external editor.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M emacs "\C-X\C-E" edit-command-line
# Inserts 'sudo ' at the beginning of the line.
function prepend-sudo {
  if [[ "$BUFFER" != su(do|)\ * ]]; then
    BUFFER="sudo $BUFFER"
    (( CURSOR += 5 ))
  fi
}
zle -N prepend-sudo
bindkey -M "emacs" "\C-X\C-S" prepend-sudo

#
# Aliases
#
#
# Utility
#
alias su="su -l"
alias _='sudo'

# ls
export LSCOLORS='exfxcxdxbxGxDxabagacad'
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'
case "${OSTYPE}" in
freebsd*|darwin*)
    alias ls="ls -G -w"
    ;;
linux*)
    alias ls="ls --color"
    ;;
esac
# Lists in one column, hidden files.
alias l='ls -1A'
# Lists human readable sizes.
alias ll='ls -lh'
# Lists human readable sizes, recursively.
alias lr='ll -R'
# Lists human readable sizes, hidden files.
alias la='ll -A'
# Lists human readable sizes, hidden files through pager.
alias lm='la | "$PAGER"'
# Lists sorted by extension (GNU only).
alias lx='ll -XB'
# Lists sorted by size, largest last.
alias lk='ll -Sr'
# Lists sorted by date, most recent last.
alias lt='ll -tr'
# Lists sorted by date, most recent last, shows change time.
alias lc='lt -c'
# Lists sorted by date, most recent last, shows access time.
alias lu='lt -u'
# auto ls after cd
function chpwd() { ls }

# mkdir
alias md='mkdir -pv'
function mkdcd {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# grep
alias grep='grep --color=auto'

# Resource Usage
alias df='df -kh'
alias du='du -kh'

# find
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# LANG
alias ja='LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8'
alias en='LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8'

# Command line head / tail shortcuts
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g NE="2> /dev/null"
alias -g NUL="> /dev/null 2>&1"

#
# Directory
#
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

#
# Archive
#
autoload -Uz lsarchive unarchive
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=unarchive

# cdr
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# peco
autoload -Uz peco-cdr
zle -N peco-cdr
bindkey '^@' peco-cdr
autoload -Uz peco-select-history
zle -N peco-select-history
bindkey '^r' peco-select-history
