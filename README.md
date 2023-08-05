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
        source "$BASE16_SHELL/profile_helper.sh"
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
 
 `gruvbox-dark-hard`

Step 5: **Install Dependancies**

 For copying mode to work smoothly, please install the following dependencies.
 `sudo apt-get install xsel`
 `sudo apt-get install xclip`
 
Step 6: **Choose Terminal**

 Some computer uses terminator as default which the color scheme does not work. You can follow the below steps to change it back to the default terminal.
 
 `sudo update-alternatives --config x-terminal-emulator`


## Installing TMUX

`sudo apt-get install tmux`

## Obtaining the .tmux.conf and tab-completion below

```sh
# Set as default tmux config
curl -o .tmux.conf https://raw.githubusercontent.com/BruceChanJianLe/TMUX_Setup/master/.tmux.conf
curl https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux > ~/.bash_completion
```

## Multiple TMUX configuration
```bash
# Clone as cjl.tmux.conf to be source later
curl -o ~/.cjl.tmux.conf https://raw.githubusercontent.com/BruceChanJianLe/TMUX_Setup/master/.tmux.conf
# Add alias to source this tmux config with command tsource
echo "alias ts='tmux source-file ~/.cjl.tmux.conf'" >> ~/.bashrc
```

## TMUX Predefined Layout

You may use the `tmux_layout.layout` as a template for your purpose.

## Keybindings / Shortcuts Keys
Action | my_TMUX | normal_TMUX | Screen
---|---|---|---
Create new session | tmux | tmux | screen
Create new  screen/window | Ctrl-w c | Ctrl-b c | Ctrl-a c
New screen/window | Ctrl-w n | Ctrl-b n | Ctrl-a n
Previous screen/window | Ctrl-w p | Ctrl-b p |Ctrl-a p
Last-used screen/window | Ctrl-w l | Ctrl-b l | Ctrl-a Ctrl-a
Show active screens/windows | Ctrl-w w | Ctrl-b w | Ctrl-a “
Name the current screen/window | Ctrl-w , | Ctrl-b , | Ctrl-a A
Detach session | Ctrl-w d | Ctrl-b d | Ctrl-a d
Enter command line | Ctrl-w : | Ctrl-b : | Ctrl-a :
Close current screen/window | Ctrl-w & | Ctrl-b & | Ctrl-a k
Close all screens | - | - | Ctrl-w \
Split pane left/right | Ctrl-w \| | Ctrl-b % | - 
Split pane top/bottom | Ctrl-w - | Ctrl-b “ | - 
Cycle between panes | Ctrl-w o | Ctrl-b o | - 
Switch to last-used pane | Ctrl-w ; | Ctrl-b ; | - 
Name the current session | Ctrl-w $ | Ctrl-b $ | - 
Promote current pane to window | Ctrl-w ! | Ctrl-b ! | - 
Display clock on window/pane | Ctrl-w t | Ctrl-b t | - 
Change arrangments of panes | Ctrl-w <Space> | Ctrl-b <Space> | -  
List running sessions | tmux ls | tmux ls | - 
Attach to a session | tmux att -t <session_number/session_name> | tmux attach -t <session_number/session_name> | -
Switch between sessions | Ctrl-w s (no longer using this) | Ctrl-a s | -
Set Session name | Ctrl-w $ | Ctrl-b $ | -
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
Display pane number | Ctrl-w q | Ctrl-b q | -
Zoom / Unzoom | Ctrl-w z | Ctrl-b z | -
Enter copy mode | Ctrl-w [ | Ctrl-b [ | -
Select from TMUX copy clipboard | Ctrl-w P | Ctrl-b P | -
Remove register from TMUX copy clipboard | Ctrl-w + | Ctrl-b + | -
Switching pane position to left | Ctrl-w { | Ctrl-b } | -
Switching pane position to right | Ctrl-w } | Ctrl-b } | -
Synchronize all panes in current window | Ctrl-w s | - | -
Unsynchronize all panes in current window | Ctrl-w S | - | -

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
unset color_prompt force_color_prompt # This is just to show you where to stop editting
```

## Display Git Branch on the Right
```bash
# ********************** To be added - Start
# https://askubuntu.com/questions/730754/how-do-i-show-the-git-branch-with-colours-in-bash-prompt
# https://wiki.archlinux.org/index.php/Bash/Prompt_customization#Colors
# https://www.youtube.com/watch?v=DxtGz2hSI00; http://linuxcommand.org/lc3_adv_tput.php
parse_git_branch() {
 git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

rightprompt()
{
    printf "%*s" $COLUMNS "$(parse_git_branch)"
}

if [ "$color_prompt" = yes ]; then
 PS1='\[$(tput sc; tput setaf 1; rightprompt; tput rc)\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
 PS1='\[$(tput sc; rightprompt; tput rc)\]${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
# ************************** To be added - End

# ************************** To be commented - Start
# if [ "$color_prompt" = yes ]; then
#     PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# else
#     PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
# fi
# ************************** To be commented - End
unset color_prompt force_color_prompt # This is just to show you where to stop editting
```
By default we shall use the left version as right display does not supported by bash.

## Tab Completion

Add this line to the end of your .bashrc after `curl https://raw.githubusercontent.com/imomaliev/tmux-bash-completion/master/completions/tmux > ~/.bash_completion
`
```bash
# Do not forget to add the complete path
. /home/$USER/.bash_completion
```

## Start TMUX by Default

```bash
# Start tmux by default
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux
fi
```

## List Available TMUX Socket

```bash
lsof -U | grep '^tmux'
```

Reference: [link](https://stackoverflow.com/questions/11333291/is-it-possible-to-find-tmux-sockets-currently-in-use)

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

## Reference

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

Reference for Tmux Commands Tab-completion | [link1](https://github.com/imomaliev/tmux-bash-completion)[link2](https://russellparker.me/post/2018/02/16/tmux-bash-autocomplete/)
--- | ---

Reference for Tmux to Start by Default | [link](https://unix.stackexchange.com/questions/43601/how-can-i-set-my-default-shell-to-start-up-tmux)
--- | ---

Reference for Tmux Scroll History | [link](https://stackoverflow.com/questions/18760281/how-to-increase-scrollback-buffer-size-in-tmux)
--- | ---

Reference for Tmux if Statement for obtaining TMUX_VERSION | [link](https://stackoverflow.com/questions/35016458/how-to-write-if-statement-in-tmux-conf-to-set-different-options-for-different-t)
 --- | ---
 
 Reference for Tmux plugin in another location | [link](https://github.com/tmux-plugins/tpm/blob/master/docs/tpm_not_working.md)
