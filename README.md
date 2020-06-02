# TMUX Setup

Following along this document to setup your bash and tmux terminal display in a much prettier way.

## Changing Bash Shell Theme

base16 | [link](https://github.com/chriskempson/base16-shell)
---|---



Step 1: **Install**

 `git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell`


Step 2: **Sourcing**

 Add following lines to ~/.bashrc or ~/.zshrc:
 ```sh
 # Base16 Shell
 BASE16_SHELL="$HOME/.config/base16-shell/"
 [ -n "$PS1" ] && \
     [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
         eval "$("$BASE16_SHELL/profile_helper.sh")"
 ```



Step 3: **Vim**

 The profile_helper will update a ~/.vimrc_background file that will have your current the colorscheme, you just need to source this file in your vimrc: i.e. (remove the base16colorspace line if not needed)
 ```
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
```


Step 4: **Choose Theme**
 
 You can choose any that you like, my choice is as shown below:
 
 `base16_atlas`

Step 5: **Install Dependancies**

 For copying mode to work smoothly, please install the following dependencies.
 `sudo apt-get install xsel`
 `sudo apt-get install xclip`
 
Step 6: **Choose Terminal**

 Some computer uses terminator as default which the color scheme does not work. You can follow the below steps to change it back to the default terminal.
 
 `sudo update-alternatives --config x-terminal-emulator`


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

Reference for Copy Mode in Tmux | [link](https://github.com/gotbletu/shownotes/blob/master/tmux_2.4_copy_mode_vim.md)
---|---

Reference for Choosing Terminal | [link](https://itsfoss.com/change-default-terminal-ubuntu/)
---|---

Reference for Scrolling in Tmux Terminal | [link](https://superuser.com/questions/209437/how-do-i-scroll-in-tmux)
--- | ---

## Obtaining the .tmux.conf below

`curl -o .tmux.conf https://raw.githubusercontent.com/BruceChanJianLe/TMUX_Setup/master/.tmux.conf`

## Customizing .tmux.conf
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
set -g display-panes-time 2000

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
# if clear command does not work, change `rxvt-unicode-256color` with `xterm-256color`
set -g default-terminal "rxvt-unicode-256color"
set -ga terminal-overrides ',rxvt-unicode-256color:Tc'

#-------- Copy Mode (Vim Style) {{{
#------------------------------------------------------
# This section of hotkeys mainly work in copy mode and no where else
 
# vim keys in copy and choose mode
set-window-option -g mode-keys vi
 
# copying selection vim style
# bind-key Escape copy-mode                       # enter copy mode; default [
# bind-key p paste-buffer                         # paste; (default hotkey: ] )
bind-key P choose-buffer                        # tmux clipboard history
bind-key + delete-buffer \; display-message "Deleted current Tmux Clipboard History"
 
# Send To Tmux Clipboard or System Clipboard
bind-key < run-shell "tmux set-buffer -- \"$(xsel -o -b)\"" \; display-message "Copy To Tmux Clipboard"
bind-key > run-shell 'tmux show-buffer | xsel -i -b' \; display-message "Copy To System Clipboard"

# set the current tmux version (use this variable on if-shell commands)
run-shell "tmux set-environment -g TMUX_VERSION $(tmux -V | cut -c 6-)"

# vim copy mode rebinds for (tmux 2.4+)
# Note: rectangle-toggle (aka Visual Block Mode) > hit v then C-v to trigger it
if-shell -b '[ "$(echo "$TMUX_VERSION >= 2.4" | bc)" = 1 ]' \
  'bind-key -T copy-mode-vi v send-keys -X begin-selection; \
  bind-key -T copy-mode-vi V send-keys -X select-line; \
  bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle; \
  bind-key -T choice-mode-vi h send-keys -X tree-collapse ; \
  bind-key -T choice-mode-vi l send-keys -X tree-expand ; \
  bind-key -T choice-mode-vi H send-keys -X tree-collapse-all ; \
  bind-key -T choice-mode-vi L send-keys -X tree-expand-all ; \
  bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe "xclip -in -selection clipboard"; \
  bind-key -T copy-mode-vi y send-keys -X copy-pipe "xclip -in -selection clipboard"'

# vim copy mode rebinds for (tmux 2.3 or lower)
if-shell -b '[ "$(echo "$TMUX_VERSION < 2.4" | bc)" = 1 ]' \
  'bind-key -t vi-copy v begin-selection; \
  bind-key -t vi-copy V select-line; \
  bind-key -t vi-copy C-v rectangle-toggle; \
  bind-key -t vi-choice h tree-collapse; \
  bind-key -t vi-choice l tree-expand; \
  bind-key -t vi-choice H tree-collapse-all; \
  bind-key -t vi-choice L tree-expand-all; \
  bind-key -t vi-copy MouseDragEnd1Pane copy-pipe "xclip -in -selection clipboard"; \
  bind-key -t vi-copy y copy-pipe "xclip -in -selection clipboard"'  
 
 #}}}

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
Close all screens | - | - | Ctrl-a \
Split pane left/right | Ctrl-a \| | Ctrl-b % | - 
Split pane top/bottom | Ctrl-a - | Ctrl-b “ | - 
Cycle between panes | Ctrl-a o | Ctrl-b o | - 
Switch to last-used pane | Ctrl-a ; | Ctrl-b ; | - 
Name the current session | Ctrl-a $ | Ctrl-b $ | - 
Promote current pane to window | Ctrl-a ! | Ctrl-b ! | - 
Display clock on window/pane | Ctrl-a t | Ctrl-b t | - 
Change arrangments of panes | Ctrl-a <Space> | Ctrl-b <Space> | -  
List running sessions | tmux ls | tmux ls | - 
Attach to a session | tmux att -t <session_number/session_name> | tmux attach -t <session_number/session_name> | -
Switch between sessions | Ctrl-a s | Ctrl-a s | -
Set Session name | Ctrl-a $ | Ctrl-b $ | -
Kill tmux session from terminal | tmux kill-sess -t <session_number/session_name> | tmux kill-session -t <session_number/session_name> | -
Scroll half page down | Ctrl-d | - | - 
Scroll half page up | Ctrl-u | - | -
Next page (forward) | Ctrl-f | - | -
Previous page (backward) | Ctrl-b | - | -
Scroll down | Ctrl-<down-arrow> or Ctrl-e | - | -
Scroll up | Ctrl-<up-arrow> or Ctrl-y | - | -
Search again | n | - | -
Reverse search | Shift-n | - | -
Search backward | ?\<word\> | - | -
Search forward | /\<word\> | - | -
Display pane number | Ctrl-b q | Ctrl-a q | -

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

## Multi-tasking in terminal

Action | Command
---|---
Run a command at background | `<command> &`
See all run commands/jobs status | `jobs`
See all run commands/jobs status list | `jobs -l`
Bring a command/job to foreground | `fg <job_number>`
Put a command/job to background | `bg <job_number>`
Kill a command/job | `kill <job_number>`
Stop a running command | `Ctrl-z` or `kill -STOP <pid_number/job_number>` 
Continue a stopped command/job | `kill -CONT <pid_number/job_number>`
To pause a process | `Ctrl-s`
To continure a paused process | `Crtl-q`

Example of <job_number> %1, %2 or %1..5
Example of <pid_number> 5249 (see from `jobs -l`)

```sh
# Background a job
bg %1

# Background most recent job
bg

# Background second most recent job
bg -
```

