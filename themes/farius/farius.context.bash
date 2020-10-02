function __powerline_node_prompt {
  local node_version=""

  node_version="$(node_version_prompt)"
  [[ -n "${node_version}" ]] && echo "${NODE_CHAR}${node_version}|${NODE_THEME_PROMPT_COLOR}"
}

function __powerline_k8s_context_prompt  {
  local kubernetes_context=""

  if _command_exists kubectl; then
    kubernetes_context="$(k8s_context_prompt)"
  fi

  [[ -n "${kubernetes_context}" ]] && echo "${KUBERNETES_CONTEXT_THEME_CHAR}${kubernetes_context}|${KUBERNETES_CONTEXT_THEME_PROMPT_COLOR}"
}
