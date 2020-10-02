# Define this here so it can be used by all of the Powerline themes
THEME_CHECK_SUDO=${THEME_CHECK_SUDO:=true}

function set_color {
  set +u
  if [[ "${1}" != "-" ]]; then
    fg="38;5;${1}"
  fi
  if [[ "${2}" != "-" ]]; then
    bg="48;5;${2}"
    [[ -n "${fg}" ]] && bg=";${bg}"
  fi
  echo -e "\[\033[${fg}${bg}m\]"
}

# MACHINE INFO SPECIFIC

function __powerline_user_info_prompt {
  local user_info=""
  local color=${USER_INFO_THEME_PROMPT_COLOR}

  if [[ "${THEME_CHECK_SUDO}" = true ]]; then
    sudo -vn 1>/dev/null 2>&1 && color=${USER_INFO_THEME_PROMPT_COLOR_SUDO}
  fi

  case "${POWERLINE_PROMPT_USER_INFO_MODE}" in
    "sudo")
      if [[ "${color}" = "${USER_INFO_THEME_PROMPT_COLOR_SUDO}" ]]; then
        user_info="!"
      fi
      ;;
    *)
      local user=${SHORT_USER:-${USER}}
      if [[ -n "${SSH_CLIENT}" ]] || [[ -n "${SSH_CONNECTION}" ]]; then
        user_info="${USER_INFO_SSH_CHAR}${user}"
      else
        user_info="${user}"
      fi
      ;;
  esac
  [[ -n "${user_info}" ]] && echo "${user_info}|${color}"
}

function __powerline_cwd_prompt {
  local cwd=$(pwd | sed "s|^${HOME}|~|")

  echo "${cwd}|${CWD_THEME_PROMPT_COLOR}"
}

function __powerline_hostname_prompt {
    echo "${SHORT_HOSTNAME:-$(hostname -s)}|${HOST_THEME_PROMPT_COLOR}"
}

function __powerline_clock_prompt {
  echo "$(date +"${THEME_CLOCK_FORMAT}")|${CLOCK_THEME_PROMPT_COLOR}"
}

function __powerline_shlvl_prompt {
  if [[ "${SHLVL}" -gt 1 ]]; then
    local prompt="${SHLVL_THEME_PROMPT_CHAR}"
    local level=$(( ${SHLVL} - 1))
    echo "${prompt}${level}|${SHLVL_THEME_PROMPT_COLOR}"
  fi
}

# COMMAND SPECIFIC

function __powerline_history_number_prompt {
  echo "${HISTORY_NUMBER_THEME_PROMPT_CHAR}\!|${HISTORY_NUMBER_THEME_PROMPT_COLOR}"
}
