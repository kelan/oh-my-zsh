# * show incoming/outogoing remote?
# * make better variable names (the 'local' doesn't seem to be working)
# * have staged vs. unstaged changes for git

# Default status characters
local modifiedColor="%{$fg[yellow]%}"
local modifiedSymbol="⚡"  #  ⑁

local addedColor="%{$fg[green]%}"
local addedSymbol="✚" # ⓐ  ⑃

local deletedColor="%{$fg[red]%}"
local deletedSymbol="✖" # ⓧ  ⑂

local renamedColor="%{$fg[blue]%}"
local renamedSymbol="➜" # ⓡ  ⑄

local unmergedColor="%{$fg[magenta]%}"
local unmergedSymbol="ⓤ" #  ⑊

local untrackedColor="%{$fg[cyan]%}"
local untrackedSymbol="?" # ⓣ ✭

# ZSH_VCS_PROMPT_CLEAN="%{$fg[green]%}☺%{$reset_color%}" #  ⑊

local ZSH_VCS_PROMPT_CLEAN_COLOR="%{$fg[green]%}"
local ZSH_VCS_PROMPT_DIRTY_COLOR="%{$fg[yellow]%}"

local ZSH_VCS_GIT_SYMBOL=±
local ZSH_VCS_HG_SYMBOL=☿


function vcs_prompt_info() {
    local INFO=
    local BRANCHNAME=
    local VCS_TYPE_SYMBOL=
    if ref=$(git symbolic-ref HEAD 2>/dev/null); then
        VCS_TYPE_SYMBOL=$ZSH_VCS_GIT_SYMBOL
        # Valid styles are "none", "short" and "long"
        # * "none" doesn't show anything
        # * "short" shows just branch name
        # * "long" shows all status indicators
        # * if nothing is specified, assume "long"
        local STYLE="$(git config prompt.style)"
        if [[ -z "$STYLE" ]]; then STYLE="long"; fi
        if [[ "$STYLE" = "short" || "$STYLE" = "long" ]]; then
            BRANCHNAME="${ref#refs/heads/}"
        fi
        if [[ "$STYLE" = "long" ]]; then
            INFO="$(vcs_prompt_status git)"
        fi
    elif BRANCHNAME=$(hg branch 2>/dev/null); then
        # TODO (kelan) add sytle config to hg
        VCS_TYPE_SYMBOL=$ZSH_VCS_HG_SYMBOL
        INFO="$INFO $(vcs_prompt_status hg)"
    fi
    echo " $INFO%S$VCS_TYPE_SYMBOL%s$BRANCHNAME%{$reset_color%}"
}

# Checks if there are commits ahead from remote
function git_prompt_ahead() {
  if $(echo "$(git log origin/$(current_branch)..HEAD 2>/dev/null)" | grep '^commit' &>/dev/null); then
    echo "$ZSH_VCS_PROMPT_AHEAD"
  fi
}

# Get the status indicators of the working tree
# NOTE: This leaves a color open at the end so the branch name can be
# printed in that color to indicate the clean/dirty status.
vcs_prompt_status() {
    local INDICATORS=""

    local STATUS_OUTPUT=""
    if [[ "$1" = git ]]; then
        STATUS_OUTPUT="$(git status --porcelain 2>/dev/null)"
    elif [[ "$1" = hg ]]; then
        STATUS_OUTPUT="$(hg status --color never 2>/dev/null)"
        # Patch Queue stuff
        PATCH_DIR="$(hg root)/.hg/patches"
        if [[ -d "$PATCH_DIR" ]]; then
            local applied="$(wc -l $PATCH_DIR/status | awk '{print $1}')"
            if [[ "$applied" = 0 ]]; then applied="" fi
            local unapplied="$(hg qunapplied | wc -l | awk '{print $1}')"
            if [[ "$unapplied" = 0 ]]; then unapplied="" fi
            QTOP_NAME="$(tail -n1 $PATCH_DIR/status | sed 's/.*://' )"
            INDICATORS="%{$fg[blue]%}Ξ$applied%{$reset_color%}$unapplied %{$fg[blue]%}$QTOP_NAME%{$reset_color%} "
        fi

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

    if [ -n "$STATUS_OUTPUT" ]; then
        local num=$(echo $STATUS_OUTPUT | grep -c '^ *M')
        if [[ "$num" != 0 ]]; then
            INDICATORS="$INDICATORS $modifiedColor$num$modifiedSymbol "
        # elif $(echo $STATUS_OUTPUT | grep '^AM ' 2>/dev/null); then
        #     INDICATORS="$INDICATORS $ZSH_VCS_PROMPT_MODIFIED"
        # elif $(echo $STATUS_OUTPUT | grep '^ T ' 2>/dev/null); then
        #   INDICATORS="$INDICATORS $ZSH_VCS_PROMPT_MODIFIED"
        fi
        num=$(echo $STATUS_OUTPUT | grep -c '^A')
        if [[ "$num" != 0 ]]; then
            INDICATORS="$INDICATORS $addedColor$num$addedSymbol "
        fi
        if [ "$1" = "git" ]; then
            num=$(echo $STATUS_OUTPUT | grep -c '^D')
        elif [ "$1" = "hg" ]; then
            # Treat missing files as deleted, because it's likely
            # that 'addremove' just wasn't called yet
            num=$(echo $STATUS_OUTPUT | grep -c '^[R!]')
        fi
        if [[ "$num" != 0 ]]; then
            INDICATORS="$INDICATORS $deletedColor$num$deletedSymbol "
        fi
        local num=$(echo $STATUS_OUTPUT | grep -c '^?')
        if [[ "$num" != 0 ]]; then
            INDICATORS="$INDICATORS $untrackedColor$num$untrackedSymbol "
        fi
        INDICATORS="$INDICATORS$ZSH_VCS_PROMPT_DIRTY_COLOR"
    else
        INDICATORS="$INDICATORS$ZSH_VCS_PROMPT_CLEAN_COLOR"
    fi

    echo $INDICATORS
}
