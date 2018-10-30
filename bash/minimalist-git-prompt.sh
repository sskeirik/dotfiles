# Note: if colors aren't working, check:
# 1) value of $TERM variable outside of tmux session
# 2) value of $TERM variable inside  of tmux session
# 3) value of terminal-overrides in tmux configuration

RESET="$(tput sgr0)"
BLUE="$(tput setaf 4)"
GREY="$(tput setaf 244)"
RED="$(tput setaf 1)"
YELLOW="$(tput setaf 3)"

git_prompt() {
  BRANCH="$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')"

  if [ ! -z "$BRANCH" ]; then
    echo -n "$YELLOW$BRANCH"

    if [ ! -z "$(git status --porcelain=v1 2> /dev/null)" ]; then
      echo " ${RED}✗"
    fi
  fi
}

PS1='
\[$BLUE\]\w$(git_prompt)
\[$GREY\]$ \[$RESET\]'
