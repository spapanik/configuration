function git_prompt_info() {
  local ref
  ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
  ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
  echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${ref#refs/heads/}$(parse_git_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}

function parse_git_dirty() {
  local STATUS=''
  local FLAGS
  FLAGS=('--porcelain=v1')
  if [[ "${DISABLE_UNTRACKED_FILES_DIRTY}" == "true" ]]; then
    FLAGS+='--untracked-files=no'
  fi
  if [[ -a .ignore-smc ]]; then
    FLAGS+='--ignore-submodules=all'
  else
    FLAGS+='--ignore-submodules=dirty'
  fi
  STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  if [[ -n ${STATUS} ]]; then
    echo "${ZSH_THEME_GIT_PROMPT_DIRTY}"
  else
    echo "${ZSH_THEME_GIT_PROMPT_CLEAN}"
  fi
}
