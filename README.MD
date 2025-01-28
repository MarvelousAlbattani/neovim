# Installation
Put this repository inside ~/.config/nvim

# Enable icons
1) Download nerd fonts
```
https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Hack.zip
```

2) Copy nerd fonts
copy the extracted content to ~/.local/share/fonts

3) Refresh fonts
Run the command:
```
fc-cache -fv
```

4) Check fonts
Run the command:
```
fc-list : family style | grep -i nerd
```
Expected result:
```
Hack Nerd Font Mono:style=Italic
Hack Nerd Font Propo:style=Italic
Hack Nerd Font Mono:style=Regular
Hack Nerd Font Propo:style=Bold
Hack Nerd Font:style=Regular
Hack Nerd Font:style=Bold Italic
Hack Nerd Font:style=Italic
Hack Nerd Font:style=Bold
Hack Nerd Font Mono:style=Bold
Hack Nerd Font Mono:style=Bold Italic
Hack Nerd Font Propo:style=Bold Italic
Hack Nerd Font Propo:style=Regular
```
