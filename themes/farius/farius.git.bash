GIT_THEME_PROMPT_DIRTY=" ${red}✗"
GIT_THEME_PROMPT_CLEAN=" ${bold_green}✓"
GIT_THEME_PROMPT_PREFIX=" ${green}|"
GIT_THEME_PROMPT_SUFFIX="${green}|"

GIT_BRANCH_MASTER_EMOJI="📦"
GIT_BRANCH_DEVELOP_EMOJI="👷"
GIT_BRANCH_FEATURE_EMOJI="💡"
GIT_BRANCH_BUGFIX_EMOJI="🐞"
GIT_BRANCH_HOTFIX_EMOJI="🌶️"
GIT_BRANCH_REFACTOR_EMOJI="🔨"
GIT_BRANCH_DOCS_EMOJI="📗"
GIT_BRANCH_OTHER_EMOJI="🌱"

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

function __git_prompt_command() {
    git_branch_emoji
    # PS1="$(__farius_clock) "
    # PS1+="$(user_host_prompt) "
    # PS1+="${reset_color}in ${green} \w"
    PS1+="\n$(scm_prompt_char_info) "
    PS1+="${green}→${reset_color} "
}
