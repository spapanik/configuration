export LSCOLORS='Gxfxcxdxbxegedabagacad'
local reset=${reset_color}
local failure=${fg_bold[red]}
local warning=${fg_bold[yellow]}
local success=${fg_bold[green]}
local branch=${fg[red]}
local git=${fg_bold[blue]}
local directory=${fg[cyan]}

if [[ -a $HOME/.light ]]; then
    local user_info=${fg_no_bold[black]}
else
    local user_info=${fg_no_bold[white]}
fi

local ret_status="%{${user_info}%}%n@%M%(?:%{${success}%}$ :%{${failure}%}$ %s)"
PROMPT='%{${success}%}%p${vim_mode} %{${directory}%}%~ %{${git}%}$(git_prompt_info)
${ret_status}%{${reset}%}'

ZSH_THEME_GIT_PROMPT_PREFIX="git:(%{${branch}%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{${git}%}) %{${warning}%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{${git}%})"
