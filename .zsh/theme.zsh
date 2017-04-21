autoload colors; colors;
local reset=${reset_color}
local failure={160}
local warning={136}
local success={64}
local branch={125}
local git={33}
local directory={37}

if [[ -a $HOME/.light ]]; then
    local user_info={240}
else
    local user_info={245}
fi

local ret_status="%(?:%{%F${success}%}:%{%F${failure}%}%s)"
local first_line="%{%F${directory}%}%~ "
local second_line="%{%F${user_info}%}%n@%M${ret_status}$%{${reset}%} "
PROMPT='${first_line}$(git_prompt_info)
${second_line}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{%F${git}%}git:(%{%F${branch}%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{%F${git}%})"
ZSH_THEME_GIT_PROMPT_DIRTY="%{%F${git}%}) %{%F${warning}%}✗"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{${reset}%}"
