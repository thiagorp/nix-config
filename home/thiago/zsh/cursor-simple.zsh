# Simple prompt for Cursor - better terminal output detection
setopt PROMPT_SUBST

# Simple prompt with git info
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '(%b) '
zstyle ':vcs_info:*' enable git

PROMPT='%2~ ${vcs_info_msg_0_}$ '
