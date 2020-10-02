function __powerline_last_status_prompt {
  [[ "$1" -ne 0 ]] && echo "${1}|${LAST_STATUS_THEME_PROMPT_COLOR}"
}

function __powerline_left_segment {
  local OLD_IFS="${IFS}"; IFS="|"
  local params=( $1 )
  IFS="${OLD_IFS}"
  local pad_before_segment=" "

  if [[ "${SEGMENTS_AT_LEFT}" -eq 0 ]]; then
    if [[ "${POWERLINE_COMPACT_BEFORE_FIRST_SEGMENT}" -ne 0 ]]; then
      pad_before_segment=""
    fi
  else
    if [[ "${POWERLINE_COMPACT_AFTER_SEPARATOR}" -ne 0 ]]; then
      pad_before_segment=""
    fi
    # Since the previous segment wasn't the last segment, add padding, if needed
    #
    if [[ "${POWERLINE_COMPACT_BEFORE_SEPARATOR}" -eq 0 ]]; then
      LEFT_PROMPT+="$(set_color - ${LAST_SEGMENT_COLOR}) ${normal}"
    fi
    if [[ "${LAST_SEGMENT_COLOR}" -eq "${params[1]}" ]]; then
      LEFT_PROMPT+="$(set_color - ${LAST_SEGMENT_COLOR})${POWERLINE_LEFT_SEPARATOR_SOFT}${normal}"
    else
      LEFT_PROMPT+="$(set_color ${LAST_SEGMENT_COLOR} ${params[1]})${POWERLINE_LEFT_SEPARATOR}${normal}"
    fi
  fi

  LEFT_PROMPT+="$(set_color - ${params[1]})${pad_before_segment}${params[0]}${normal}"
  LAST_SEGMENT_COLOR=${params[1]}
  (( SEGMENTS_AT_LEFT += 1 ))
}

function __powerline_left_last_segment_padding {
  LEFT_PROMPT+="$(set_color - ${LAST_SEGMENT_COLOR}) ${normal}"
}

function __powerline_prompt_command {
  local last_status="$?" ## always the first
  local separator_char="${POWERLINE_PROMPT_CHAR}"

  LEFT_PROMPT=""
  SEGMENTS_AT_LEFT=0
  LAST_SEGMENT_COLOR=""


  if [[ -n "${POWERLINE_PROMPT_DISTRO_LOGO}" ]]; then
      LEFT_PROMPT+="$(set_color ${PROMPT_DISTRO_LOGO_COLOR} ${PROMPT_DISTRO_LOGO_COLORBG})${PROMPT_DISTRO_LOGO}$(set_color - -)"
  fi

  ## left prompt ##
  for segment in $POWERLINE_PROMPT; do
    local info="$(__powerline_${segment}_prompt)"
    [[ -n "${info}" ]] && __powerline_left_segment "${info}"
  done

  [[ "${last_status}" -ne 0 ]] && __powerline_left_segment $(__powerline_last_status_prompt ${last_status})

  if [[ -n "${LEFT_PROMPT}" ]] && [[ "${POWERLINE_COMPACT_AFTER_LAST_SEGMENT}" -eq 0 ]]; then
    __powerline_left_last_segment_padding
  fi

  # By default we try to match the prompt to the adjacent segment's background color,
  # but when part of the prompt exists within that segment, we instead match the foreground color.
  local prompt_color="$(set_color ${LAST_SEGMENT_COLOR} -)"
  if [[ -n "${LEFT_PROMPT}" ]] && [[ -n "${POWERLINE_LEFT_LAST_SEGMENT_PROMPT_CHAR}" ]]; then
    LEFT_PROMPT+="$(set_color - ${LAST_SEGMENT_COLOR})${POWERLINE_LEFT_LAST_SEGMENT_PROMPT_CHAR}"
    prompt_color="${normal}"
  fi
  [[ -n "${LEFT_PROMPT}" ]] && LEFT_PROMPT+="${prompt_color}${separator_char}${normal}"

  if [[ "${POWERLINE_COMPACT_PROMPT}" -eq 0 ]]; then
    LEFT_PROMPT+=" "
  fi

  PS1="${LEFT_PROMPT}"
  __git_prompt_command

  ## cleanup ##
  unset LAST_SEGMENT_COLOR \
        LEFT_PROMPT \
        SEGMENTS_AT_LEFT
}
