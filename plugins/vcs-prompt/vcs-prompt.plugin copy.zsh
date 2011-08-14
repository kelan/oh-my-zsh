# * show remote?
# * use green branchname background if clean, yellow otherwise

# Default status characters
ZSH_VCS_PROMPT_UNTRACKED="%{$fg[cyan]%}?" # ⓣ ✭
ZSH_VCS_PROMPT_ADDED="%{$fg[green]%}ⓐ " #  ⑃
ZSH_VCS_PROMPT_MODIFIED="%{$fg[yellow]%}⚡ "  #  ⑁
ZSH_VCS_PROMPT_DELETED="%{$fg[red]%}ⓧ " #  ⑂
ZSH_VCS_PROMPT_RENAMED="%{$fg[blue]%}ⓡ " #  ⑄
ZSH_VCS_PROMPT_UNMERGED="%{$fg[magenta]%}ⓤ " #  ⑊
# ZSH_VCS_PROMPT_CLEAN="%{$fg[green]%}☺%{$reset_color%}" #  ⑊

function vcs_prompt_info() {
    local INFO=""
    local branchName=
    local isClean=0
    if ref=$(git symbolic-ref HEAD 2>/dev/null); then
        # Valid styles are "short" and "long"
        # * "short" shows just branch name
        # * empty or "long" shows all status indicators
        local STYLE=$(git config prompt.style)
        if [[ -z "$STYLE" || "$STYLE" = "short" || "$STYLE" = "long" ]]; then
            # Show branch name for both styles, or if none specified
            INFO="%{$fg_bold[cyan]%}%S±%s %{$reset_color%}%{$fg[cyan]%}${ref#refs/heads/}"
        fi
        if [[ -z "$STYLE" || "$STYLE" = "long" ]]; then
            # Show status indicators by default, or for long sytle
            INFO="$INFO$(vcs_prompt_status git)"
        fi
    elif branch=$(hg branch 2>/dev/null); then
        # TODO (kelan) add sytle config to hg
        INFO="%{$fg[green]%}%S☿ ${branch}%s"
        INFO="$INFO $(vcs_prompt_status hg)"
    fi
    echo "$INFO%{$reset_color%}"
}

# Checks if there are commits ahead from remote
function git_prompt_ahead() {
  if $(echo "$(git log origin/$(current_branch)..HEAD 2>/dev/null)" | grep '^commit' &>/dev/null); then
    echo "$ZSH_VCS_PROMPT_AHEAD"
  fi
}

# Get the status of the working tree
vcs_prompt_status() {
    local STATUS_OUTPUT=""
    if [[ "$1" = git ]]; then
        STATUS_OUTPUT="$(git status --porcelain 2>/dev/null)"
    elif [[ "$1" = hg ]]; then
        STATUS_OUTPUT="$(hg status --color never 2>/dev/null)"
    fi

    # hg help status:
    # M = modified
    # A = added
    # R = removed
    # C = clean
    # ! = missing (deleted by non-hg command, but still tracked)
    # ? = not tracked

    #   = origin of the previous file listed as A (added)

    # git help status:
    # M = modified
    # A = added
    # D = deleted
    # R = renamed
    # C = copied
    # U = updated but unmerged

    local INDICATORS=""
    if [ -n "$STATUS_OUTPUT" ]; then
        if local MODIFIED="$(echo $STATUS_OUTPUT | grep '^\s*M' --color=never 2>/dev/null)"; then
            local NUM="$(echo $MODIFIED | wc -l | awk '{print $1}')"
            # if [ "$NUM" = "1" ]; then NUM=""; fi
            INDICATORS="$INDICATORS $ZSH_VCS_PROMPT_MODIFIED$NUM"
        # elif $(echo $STATUS_OUTPUT | grep '^AM ' 2>/dev/null); then
        #     INDICATORS="$INDICATORS $ZSH_VCS_PROMPT_MODIFIED"
        # elif $(echo $STATUS_OUTPUT | grep '^ T ' 2>/dev/null); then
        #   INDICATORS="$INDICATORS $ZSH_VCS_PROMPT_MODIFIED"
        fi
        if local ADDED="$(echo $STATUS_OUTPUT | grep '^A' 2>/dev/null)"; then
            local NUM="$(echo $ADDED | wc -l | awk '{print $1}' 2>/dev/null)"
            # if [ "$NUM" = "1" ]; then NUM=""; fi
            INDICATORS="$INDICATORS $ZSH_VCS_PROMPT_ADDED$NUM"
        fi
        local DELETED=""
        if [ "$1" = "git" ]; then
            DELETED=$(echo $STATUS_OUTPUT | grep '^D' 2>/dev/null)
        elif [ "$1" = "hg" ]; then
            DELETED=$(echo $STATUS_OUTPUT | grep '^R' 2>/dev/null)
        fi
        if [ -n "$DELETED" ]; then
            local NUM=$(echo $DELETED | wc -l | awk '{print $1}' 2>/dev/null)
            # if [ "$NUM" = "1" ]; then NUM=""; fi
            INDICATORS="$INDICATORS $ZSH_VCS_PROMPT_DELETED$NUM"
        fi
        # if local UNTRACKED=$(echo $STATUS_OUTPUT | grep '^\?' 2>/dev/null); then
        if local UNTRACKED=$(echo $STATUS_OUTPUT | grep '^G' 2>/dev/null); then
            local NUM=$(echo $UNTRACKED | wc -l | awk '{print $1}' 2>/dev/null)
            # if [ "$NUM" = "1" ]; then NUM=""; fi
            INDICATORS="$INDICATORS $ZSH_VCS_PROMPT_UNTRACKED$NUM"
        fi
        # if local RENAMED=$(echo $STATUS_OUTPUT | grep '^R  ' 2>/dev/null); then
        #     local NUM=$(echo $RENAMED | wc -l | awk '{print $1}')
        #     if [ "$NUM" = "1" ]; then NUM=""; fi
        #     INDICATORS="$INDICATORS $ZSH_VCS_PROMPT_RENAMED$NUM"
        # fi
        # if $(echo $STATUS_OUTPUT | grep '^UU ' 2>/dev/null); then
        #   INDICATORS="$INDICATORS $ZSH_VCS_PROMPT_UNMERGED"
        # fi
    # else
    #     INDICATORS="$ZSH_VCS_PROMPT_CLEAN"
    fi

    echo $INDICATORS
}
