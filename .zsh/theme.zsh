# ANSI colors
local reset="%{${reset_color}%}"

local black="${reset}%{${fg[black]}%}"
local red="${reset}%{${fg[red]}%}"
local green="${reset}%{${fg[green]}%}"
local yellow="${reset}%{${fg[yellow]}%}"
local blue="${reset}%{${fg[blue]}%}"
local magenta="${reset}%{${fg[magenta]}%}"
local cyan="${reset}%{${fg[cyan]}%}"
local white="${reset}%{${fg[white]}%}"

local bold_black="${reset}%{${fg_bold[black]}%}"
local bold_red="${reset}%{${fg_bold[red]}%}"
local bold_green="${reset}%{${fg_bold[green]}%}"
local bold_yellow="${reset}%{${fg_bold[yellow]}%}"
local bold_blue="${reset}%{${fg_bold[blue]}%}"
local bold_magenta="${reset}%{${fg_bold[magenta]}%}"
local bold_cyan="${reset}%{${fg_bold[cyan]}%}"
local bold_white="${reset}%{${fg_bold[white]}%}"

# prompt commands
local directory="%~"
local prompt_sign="%(!.#.$)"
local ret_status="%(?.${green}.${red})"

function user_info() {
    if [[ -n ${HIDE_USER} ]]; then
        local user="********"
        local server="********"
    else
        local user="%n"
        local server="%m"
    fi
    echo "${USER_INFO_PREFIX}${user}@${server}${USER_INFO_SUFFIX} "
}

# custom venv prompt
export VIRTUAL_ENV_DISABLE_PROMPT=1
function venv_info() {
    if [[ -n ${VIRTUAL_ENV} ]]; then
        echo "${VENV_PROMPT_PREFIX}$(basename ${VIRTUAL_ENV})${VENV_PROMPT_SUFFIX} "
    fi
}

# prompt variables
if [[ -a $HOME/.light ]]; then
    USER_INFO_PREFIX=${black}
else
    USER_INFO_PREFIX=${white}
fi
USER_INFO_SUFFIX="${reset}"

VENV_PROMPT_PREFIX="${bold_blue}venv:(${red}"
VENV_PROMPT_SUFFIX="${bold_blue})${reset}"

ZSH_THEME_GIT_PROMPT_PREFIX="${bold_blue}git:(${red}"
ZSH_THEME_GIT_PROMPT_CLEAN="${bold_blue})"
ZSH_THEME_GIT_PROMPT_DIRTY="${bold_blue}) ${bold_yellow}✗"
ZSH_THEME_GIT_PROMPT_SUFFIX="${reset}"

PROMPT='$(venv_info)${cyan}${directory} $(git_prompt_info)
$(user_info)${ret_status}${prompt_sign}${reset} '

autoload colors && colors
