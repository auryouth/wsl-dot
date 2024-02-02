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
