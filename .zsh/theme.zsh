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

local ret_status="%(?:%{${success}%}:%{${failure}%}%s)"
local first_line="%{${directory}%}%~ "
local second_line="%{${user_info}%}%n@%M${ret_status}$%{${reset}%} "
PROMPT='${first_line}$(git_prompt_info)
${second_line}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{${git}%}git:(%{${branch}%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{${git}%})"
ZSH_THEME_GIT_PROMPT_DIRTY="%{${git}%}) %{${warning}%}✗"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{${reset}%}"
