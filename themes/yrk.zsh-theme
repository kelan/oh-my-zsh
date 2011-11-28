# Took some things from:
# * wedisagree.zsh-theme
# * dogenpunk.zsh-theme
# * jnrowse.zsh-theme (ret_status, I think)
# * http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt

# This s for vi-mode
MODE_INDICATOR="%{$fg_bold[magenta]%}❮%{$reset_color%}%{$fg[red]%}❮❮%{$reset_color%}"

local ret_status="%(?::%{$fg_bold[red]%}%?↵  %{$reset_color%})"

PROMPT='%{$fg[magenta]%}\$%{$reset_color%} '

# The right-hand prompt
RPROMPT='${ret_status}%{$fg[magenta]%}[%4c]%{$reset_color%}$(vcs_prompt_info)'


