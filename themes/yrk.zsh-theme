# Based on wedisagree.zsh-theme
# with some tips from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt

# This s for vi-mode
MODE_INDICATOR="%{$fg_bold[magenta]%}❮%{$reset_color%}%{$fg[red]%}❮❮%{$reset_color%}"

# from http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt and also
# in the dogenpunk theme, and 
function prompt_char {
    # git branch >/dev/null 2>/dev/null && echo '±' && return
    # hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '$'
}

# from the jnrowse.zsh-theme (for the up-pointing status return).
local ret_status="%(?::%{$fg_bold[red]%}%?↵  %{$reset_color%})"

# PROMPT='%{$fg[magenta]%}[%c $(git_prompt_info) ]
# PROMPT='${time} %{$fg[magenta]%}$(git_prompt_info)--%{$reset_color%}$(git_prompt_status)%{$reset_color%}--HG:$(hg_prompt_info)
# PROMPT='%{$fg[magenta]%}[%c] %{$reset_color%}'

# Final 2 lines:
# PROMPT='%{$fg[magenta]%}[%~]%{$reset_color%}
# ${ret_status}%{$fg[magenta]%}$(prompt_char)%{$reset_color%} '

# Final 1 line (path info goes on right)
PROMPT='%{$fg[magenta]%}\$%{$reset_color%} '

# The right-hand prompt
# RPROMPT='${time} %{$fg[magenta]%}$(git_prompt_info)%{$reset_color%}$(git_prompt_status)%{$reset_color%}'
# RPROMPT='$(vi_mode_prompt_info)${return_status}%{$fg[magenta]%}[%c]%{$reset_color%} '
# RPROMPT='${return_status}$(git_prompt_info)$(git_prompt_status)$(hg_prompt_info)$(hg_prompt_status)%{$reset_color%}'

# Final:
RPROMPT='${ret_status}%{$fg[magenta]%}[%4c]%{$reset_color%}$(vcs_prompt_info)'

# Add this at the start of RPROMPT to include rvm info showing ruby-version@gemset-name
# %{$fg[yellow]%}$(~/.rvm/bin/rvm-prompt)%{$reset_color%} 

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg[cyan]%}☿ " # ⓗ
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[cyan]%}± " # ⓖ
ZSH_THEME_GIT_PROMPT_SUFFIX=" %{$reset_color%}"

# Dirty status is shown by more specific symbols below, and if it's clean
# just don't show any symbols.
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} ⚡%{$reset_color%}" # Ⓓ
ZSH_THEME_GIT_PROMPT_DIRTY=""
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}☀ %{$reset_color%}" # Ⓞ
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Original
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}?%{$reset_color%}" # ⓣ ✭
# ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%}✚ %{$reset_color%}" # ⓐ ⑃
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} %{$reset_color%}"  # ⓜ ⑁
# ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}✖ %{$reset_color%}" # ⓧ ⑂
# ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}➜ %{$reset_color%}" # ⓡ ⑄
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}♒ %{$reset_color%}" # ⓤ ⑊

# next
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}?%{$reset_color%}" # ⓣ ✭
# ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}ⓐ %{$reset_color%}" #  ⑃
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⚡ %{$reset_color%}"  #  ⑁
# ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}ⓧ %{$reset_color%}" #  ⑂
# ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}ⓡ %{$reset_color%}" #  ⑄
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}ⓤ %{$reset_color%}" #  ⑊

# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%}?" # ⓣ ✭
# ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%}ⓐ " #  ⑃
# ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%}⚡ "  #  ⑁
# ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}ⓧ " #  ⑂
# ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%}ⓡ " #  ⑄
# ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%}ⓤ " #  ⑊

# More symbols to choose from:
# ☀ ✹ ☄ ♆ ♀ ♁ ♐ ♇ ♈ ♉ ♚ ♛ ♜ ♝ ♞ ♟ ♠ ♣ ⚢ ⚲ ⚳ ⚴ ⚥ ⚤ ⚦ ⚒ ⚑ ⚐ ♺ ♻ ♼ ☰ ☱ ☲ ☳ ☴ ☵ ☶ ☷
# ✡ ✔ ✖ ✚ ✱ ✤ ✦ ❤ ➜ ➟ ➼ ✂ ✎ ✐ ⨀ ⨁ ⨂ ⨍ ⨎ ⨏ ⨷ ⩚ ⩛ ⩡ ⩱ ⩲ ⩵  ⩶ ⨠ 
# ⬅ ⬆ ⬇ ⬈ ⬉ ⬊ ⬋ ⬒ ⬓ ⬔ ⬕ ⬖ ⬗ ⬘ ⬙ ⬟  ⬤ 〒 ǀ ǁ ǂ ĭ Ť Ŧ

# local return_status="%(?..%{$fg[red]%}%?↵%{$reset_color%})"
# local ret_status="%(?:%{$fg_bold[green]%}Ξ:%{$fg_bold[red]%}%S↑%s%?)"


# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
function git_time_since_commit() {
    if git rev-parse --git-dir > /dev/null 2>&1; then
        # Only proceed if there is actually a commit.
        if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
            # Get the last commit.
            last_commit=`git log --pretty=format:'%at' -1 2> /dev/null`
            now=`date +%s`
            seconds_since_last_commit=$((now-last_commit))

            # Totals
            MINUTES=$((seconds_since_last_commit / 60))
            HOURS=$((seconds_since_last_commit/3600))
           
            # Sub-hours and sub-minutes
            DAYS=$((seconds_since_last_commit / 86400))
            SUB_HOURS=$((HOURS % 24))
            SUB_MINUTES=$((MINUTES % 60))
            
            if [[ -n $(git status -s 2> /dev/null) ]]; then
                if [ "$MINUTES" -gt 30 ]; then
                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
                elif [ "$MINUTES" -gt 10 ]; then
                    COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
                else
                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
                fi
            else
                COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            fi

            if [ "$HOURS" -gt 24 ]; then
                echo "($COLOR${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%{$reset_color%}|"
            elif [ "$MINUTES" -gt 60 ]; then
                echo "($COLOR${HOURS}h${SUB_MINUTES}m%{$reset_color%}|"
            else
                echo "($COLOR${MINUTES}m%{$reset_color%}|"
            fi
        else
            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
            echo "($COLOR~|"
        fi
    fi
}


