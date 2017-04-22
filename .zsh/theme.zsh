# ANSI colors
local black="%{${fg[black]}%}"
local red="%{${fg[red]}%}"
local green="%{${fg[green]}%}"
local yellow="%{${fg[yellow]}%}"
local blue="%{${fg[blue]}%}"
local magenta="%{${fg[magenta]}%}"
local cyan="%{${fg[cyan]}%}"
local white="%{${fg[white]}%}"

local bold_black="%{${fg_bold[black]}%}"
local bold_red="%{${fg_bold[red]}%}"
local bold_green="%{${fg_bold[green]}%}"
local bold_yellow="%{${fg_bold[yellow]}%}"
local bold_blue="%{${fg_bold[blue]}%}"
local bold_magenta="%{${fg_bold[magenta]}%}"
local bold_cyan="%{${fg_bold[cyan]}%}"
local bold_white="%{${fg_bold[white]}%}"



# prompt commands
local reset="%{${reset_color}%}"
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

VENV_PROMPT_PREFIX="${bold_blue}venv:(${bold_red}"
VENV_PROMPT_SUFFIX="${bold_blue})${reset}"

ZSH_THEME_GIT_PROMPT_PREFIX="${bold_blue}git:(${bold_red}"
ZSH_THEME_GIT_PROMPT_CLEAN="${bold_blue})"
ZSH_THEME_GIT_PROMPT_DIRTY="${bold_blue}) ${yellow}✗"
ZSH_THEME_GIT_PROMPT_SUFFIX="${reset}"

PROMPT='$(venv_info)${cyan}${directory} $(git_prompt_info)
$(user_info)${ret_status}${prompt_sign}${reset} '

autoload colors && colors
