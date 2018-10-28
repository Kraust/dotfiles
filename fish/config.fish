#!/usr/bin/fish

set -x PATH $PATH /home/kraust/bin

if status --is-login
  if test -z "$DISPLAY" -a $XDG_VTNR = 1
    exec startx -- -keeptty >~/.xorg.log ^&1
  end
end

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

alias vim "nvim"
alias htop "sudo htop"

set fish_prompt_pwd_dir_length  0
set fish_greeting

set fish_color_cwd      cyan --bold #--background=default cyan --bold
set fish_color_vcs      white #--background=default white
set fish_color_user     white #--background=default white
set fish_color_host     white #--background=default white
set fish_color_status   white #--background=default white

set -x DXVK_HUD 1


#
neofetch
