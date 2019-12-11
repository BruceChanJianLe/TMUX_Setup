# TMUX Setup

Following along this document to setup your bash and tmux terminal display in a much prettier way.

## Changing Bash Shell Theme

base16 | [link](https://github.com/chriskempson/base16-shell)
---|---

=================================================================================================================================================

Step 1: **Install**

 `git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell`

=================================================================================================================================================

Step 2: **Sourcing**

 Add following lines to ~/.bashrc or ~/.zshrc:
 ```sh
 # Base16 Shell
 BASE16_SHELL="$HOME/.config/base16-shell/"
 [ -n "$PS1" ] && \
     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
         eval "$("$BASE16_SHELL/profile_helper.sh")"
 ```

=================================================================================================================================================

Step 3: **Vim**

 The profile_helper will update a ~/.vimrc_background file that will have your current the colorscheme, you just need to source this file in your vimrc: i.e. (remove the base16colorspace line if not needed)
 ```
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
```

=================================================================================================================================================

Step 4: **Choose Theme**
 
 You can choose any that you like, my choice is as shown below:
 
 `base16_atlas`

=================================================================================================================================================

## Installing TMUX

`sudo apt-get install tmux`

Solve tmux color display | [link](https://github.com/tmux/tmux/issues/1651)
---|---

Solve tmux terminal from printing weird characters | [link](https://unix.stackexchange.com/questions/320465/new-tmux-sessions-do-not-source-bashrc-file)
---|---

Reference for tmux.conf 1 | [link](https://gist.github.com/spicycode/1229612)
---|---

Reference for tmux.conf 2 | [link](https://github.com/sbernheim4/dotfiles/blob/master/.tmux.conf)
---|---

## Customizing tmux.conf
```sh
# Add mouse scroll
setw -g mouse on

# Indicate to use bash in tmux
set-option -g default-shell "/bin/bash"

# 0 is too far from ` ;)
set -g base-index 1

set -s escape-time 0

# remap prefix from 'C-b' to 'C-a'
unbind C-b
set-option -g prefix C-a
bind-key C-a send-prefix

# Split pane  to current directory
bind | split-window -h -c "#{pane_current_path}"
bind - split-window -v -c "#{pane_current_path}"


# Movement keys (like vim)
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R


# Resize panes
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

######################
### DESIGN CHANGES ###
######################

# loud or quiet?
set -g visual-activity off
set -g visual-bell off
set -g visual-silence off
setw -g monitor-activity off
set -g bell-action none

#  modes
setw -g clock-mode-colour colour5
setw -g mode-style 'fg=colour1 bg=colour18 bold'

# panes
set -g pane-border-style 'fg=colour19 bg=colour0'
set -g pane-active-border-style 'bg=colour0 fg=colour9'

# statusbar
set -g status-position bottom
set -g status-justify left
set -g status-style 'bg=colour18 fg=colour137 dim'
set -g status-left ''
set -g status-right '#[fg=colour233,bg=colour19] %d/%m #[fg=colour233,bg=colour8] %H:%M:%S '
set -g status-right-length 50
set -g status-left-length 20

setw -g window-status-current-style 'fg=colour1 bg=colour19 bold'
setw -g window-status-current-format ' #I#[fg=colour249]:#[fg=colour255]#W#[fg=colour249]#F '

setw -g window-status-style 'fg=colour9 bg=colour18'
setw -g window-status-format ' #I#[fg=colour237]:#[fg=colour250]#W#[fg=colour244]#F '

setw -g window-status-bell-style 'fg=colour255 bg=colour1 bold'

# messages
set -g message-style 'fg=colour232 bg=colour16 bold'

# Fix tmux colors
set -g default-terminal "rxvt-unicode-256color"
set -ga terminal-overrides ',rxvt-unicode-256color:Tc'
```

## Keybindings / Shortcuts Keys
Action | my_TMUX | normal_TMUX | Screen
---|---|---|---
Create new session | tmux | tmux | screen
Create new  screen/window | Ctrl-a c | Ctrl-b c | Ctrl-a c
New screen/window | Ctrl-a n | Ctrl-b n | Ctrl-a n
Previous screen/window | Ctrl-a p | Ctrl-b p |Ctrl-a p
Last-used screen/window | Ctrl-a l | Ctrl-b l | Ctrl-a Ctrl-a
Show active screens/windows | Ctrl-a w | Ctrl-b w | Ctrl-a “
Name the current screen/window | Ctrl-a , | Ctrl-b , | Ctrl-a A
Detach session | Ctrl-a d | Ctrl-b d | Ctrl-a d
Enter command line | Ctrl-a : | Ctrl-b : | Ctrl-a :
Close current screen/window | Ctrl-a & | Ctrl-b & | Ctrl-a k
Close all screens | | | Ctrl-a \
Split pane left/right | Ctrl-a \| | Ctrl-b % | 
Split pane top/bottom | Ctrl-a - | Ctrl-b “ | 
Cycle between panes | Ctrl-a o | Ctrl-b o |
Switch to last-used pane | Ctrl-a ; | Ctrl-b ; | 
Name the current session | Ctrl-a $ | Ctrl-b $ |

## Display Git Branch

Show Git Branch in Terminal | [link](https://askubuntu.com/questions/730754/how-do-i-show-the-git-branch-with-colours-in-bash-prompt)
---|---

Comment out the below lines and add in these new lines
```sh
# ********************** To be added - Start
# https://askubuntu.com/questions/730754/how-do-i-show-the-git-branch-with-colours-in-bash-prompt
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
if [ "$color_prompt" = yes ]; then
 PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '
else
 PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\$ '
fi
# ************************** To be added - End

# ************************** To be commented - Start
# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# ************************** To be commented - End
unset color_prompt force_color_prompt
```
