source $HOME/.config/fzf/completion.zsh
source $HOME/.config/fzf/key-bindings.zsh

# trigger key
export FZF_COMPLETION_TRIGGER='\'


# Switch between Ripgrep launcher mode (CTRL-R) and fzf filtering mode (CTRL-F)
# fd and scripts
 export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"


########################################################
######                Colorscheme 	          ######
########################################################

# # Morhetz/Gruvbox
#Gruvbox="
#--color=bg+:#3c3836,bg:#32302f,hl:#928374,fg:#ebdbb2,fg+:#ebdbb2,hl+:#fb4934
#--color=spinner:#fb4934,header:#928374,info:#8ec07c,pointer:#fb4934,marker:#fb4934,prompt:#fb4934#--height 80%
#--layout=reverse
#--border
#--preview '$HOME/.config/fzf/fzf-scope.sh {} '
#--bind 'f1:execute(less -f {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'
#"

# Seoul256 Dusk
#Seoul256="
#--color=bg+:239,bg:236,hl:65,fg:242,fg+:15,hl+:108
#--color=spinner:108,info:108,pointer:168,marker:168,prompt:109#--height 80%
#--layout=reverse
#--border
#--preview '$HOME/.config/fzf/fzf-scope.sh {} '
#--bind 'f1:execute(less -f {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'
#"

# Catppuccin
# Catppuccin="
# --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
# --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
# --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
# --height 80%
# --layout=reverse
# --border
# --preview '$HOME/.config/fzf/fzf-scope.sh {} '
# --bind 'f1:execute(less -f {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'
# "

# Dracula
Dracula="
--color=dark
--color=fg:-1,bg:-1,hl:#5fff87,fg+:-1,bg+:-1,hl+:#ffaf5f
--color=info:#af87ff,prompt:#5fff87,pointer:#ff87d7,marker:#ff87d7,spinner:#ff87d7
--height 80%
--layout=reverse
--border
--preview '$HOME/.config/fzf/fzf-scope.sh {} '
--bind 'f1:execute(less -f {}),ctrl-y:execute-silent(echo {} | pbcopy)+abort'
"

export FZF_DEFAULT_OPTS=$Dracula



# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" --exclude ".deepinwine" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" --exclude ".deepinwine" . "$1"
}





########################################################
######              other options                 ######
########################################################

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
    local pid 
    if [ "$UID" != "0" ]; then
        pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
    else
        pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
    fi  

    if [ "x$pid" != "x" ]
    then
        echo $pid | xargs kill -${1:-9}
    fi  
}


##Man pages
fman() {
    man -k . | fzf -q "$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man | col -bx | bat -l man -p --color always' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
}
# Get the colors in the opened man page itself
export MANPAGER="sh -c 'col -bx | bat -l man -p --paging always'"


# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --hidden --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --hidden --pretty --context 10 '$1' || rg --hidden --ignore-case --pretty --context 10 '$1' {}"
}



# cdf - cd into the directory of the selected file
cdf() {
   local file
   local dir
   file=$(fzf +m -q "$1") && dir=$(dirname "$file") && cd "$dir"
}
