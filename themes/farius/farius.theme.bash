#!/usr/bin/env bash

SCM_THEME_PROMPT_DIRTY=" ${red}✗"
SCM_THEME_PROMPT_CLEAN=" ${bold_green}✓"
SCM_THEME_PROMPT_PREFIX=" ${green}|"
SCM_THEME_PROMPT_SUFFIX="${green}|"

GIT_THEME_PROMPT_DIRTY=" ${red}✗"
GIT_THEME_PROMPT_CLEAN=" ${bold_green}✓"
GIT_THEME_PROMPT_PREFIX=" ${green}|"
GIT_THEME_PROMPT_SUFFIX="${green}|"

RVM_THEME_PROMPT_PREFIX="|"
RVM_THEME_PROMPT_SUFFIX="|"

THEME_SHOW_USER_HOST=true

GIT_BRANCH_MASTER_EMOJI="📦"
GIT_BRANCH_DEVELOP_EMOJI="👷"
GIT_BRANCH_FEATURE_EMOJI="💡"
GIT_BRANCH_BUGFIX_EMOJI="🐞"
GIT_BRANCH_HOTFIX_EMOJI="🌶️"
GIT_BRANCH_REFACTOR_EMOJI="🔨"
GIT_BRANCH_DOCS_EMOJI="📗"
GIT_BRANCH_OTHER_EMOJI="🌱"


function battery_char {
    if [[ "${THEME_BATTERY_PERCENTAGE_CHECK}" = true ]]; then
        echo -e "🔋 ${bold_red}$(battery_percentage)%"
    fi
}

__farius_clock() {
  if [ "${THEME_SHOW_CLOCK_CHAR}" == "true" ]; then
    printf "$(clock_char) "
  fi
  printf "$(clock_prompt)"
}

function user_host_prompt {
  if [[ "${THEME_SHOW_USER_HOST}" = "true" ]]; then
      echo -e "${yellow}${USER_HOST_THEME_PROMPT_PREFIX}\u${reset_color}@${purple}\h${USER_HOST_THEME_PROMPT_SUFFIX}"
  fi
}

function git_branch_emoji() {
  GIT_BRANCH=$(_git-branch)
  if [[ "$GIT_BRANCH" = "master" ]]; then
    SCM_GIT_CHAR="${GIT_BRANCH_MASTER_EMOJI}"
  elif [[ "$GIT_BRANCH" = "develop" ]]; then
    SCM_GIT_CHAR="${GIT_BRANCH_DEVELOP_EMOJI}"
  elif [[ "$GIT_BRANCH" =~ feature ]]; then
    SCM_GIT_CHAR="${GIT_BRANCH_FEATURE_EMOJI}"
  elif [[ "$GIT_BRANCH" =~ bug ]]; then
    SCM_GIT_CHAR="${GIT_BRANCH_BUGFIX_EMOJI}"
  elif [[ "$GIT_BRANCH" =~ hotfix ]]; then
    SCM_GIT_CHAR="${GIT_BRANCH_HOTFIX_EMOJI}"
  elif [[ "$GIT_BRANCH" =~ refactor ]]; then
    SCM_GIT_CHAR="${GIT_BRANCH_REFACTOR_EMOJI}"
  elif [[ "$GIT_BRANCH" =~ docs ]]; then
    SCM_GIT_CHAR="${GIT_BRANCH_DOCS_EMOJI}"
  else
    SCM_GIT_CHAR="${GIT_BRANCH_OTHER_EMOJI}"
  fi
}

function prompt_command() {
    git_branch_emoji
    #PS1="${bold_cyan}$(scm_char)${green}$(scm_prompt_info)${purple}$(ruby_version_prompt) ${yellow}\h ${reset_color}in ${green}\w ${reset_color}\n${green}→${reset_color} "
    # PS1="\n$(battery_char) $(__farius_clock)${yellow}$(ruby_version_prompt) $(user_host_prompt) ${reset_color}in ${green}\w\n$(scm_prompt_char_info) ${green}→${reset_color} "
    PS1="$(user_host_prompt) ${reset_color}in ${green}\w\n$(scm_prompt_char_info) ${green}→${reset_color} "
}

THEME_SHOW_CLOCK_CHAR=${THEME_SHOW_CLOCK_CHAR:-"true"}
THEME_CLOCK_CHAR_COLOR=${THEME_CLOCK_CHAR_COLOR:-"$red"}
THEME_CLOCK_COLOR=${THEME_CLOCK_COLOR:-"$bold_cyan"}
THEME_CLOCK_FORMAT=${THEME_CLOCK_FORMAT:-"%Y-%m-%d %H:%M:%S"}

safe_append_prompt_command prompt_command
