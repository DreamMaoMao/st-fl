# st-fl
support select buffer like flash.nvim 

https://github.com/user-attachments/assets/dbcf0b58-b001-455e-9fd0-33b1a18934d0

# mode enter key default
```
ctrl + shift + space : move mode
ctrl + shift + f : search forward
ctrl + shift + b : search backward
ctri + i : flash mode
```
`you can change it in config.h`

# move mode key
```
h, j, k, l:              move cursor left/down/up/right (also with arrow keys)
J,K:                     move cursor down*5/up*5
(b), (M), (E):     move cursor to the top/middle/bottom of the screen
Home, End:               move cursor to the top/bottom of the screen
Backspace or 0, $ or A:  move cursor to the beginning/end of the line
^ or I:                  move cursor to the beginning of the indented line
!:                       move cursor to the middle of the row
_:                       move cursor to the right edge of the screen
o:                       move cursor to the beginning or end of the selection
O:                       move cursor to the opposite corner of the rectangular selection
w, W                     jump forward to the start of a word
e                        jump forward to the end of a word (long match)
b                        jump backward to the start of a word (long match)
L                        jump forward to the end of a word
H                        jump backward to the start of a word
g, G:                    go to the first/last line
z:                       center the screen on the cursor
(PgUp,u,U), (PgDown,d,D):scroll the page up/down
/, ?:                    activate input mode and search forward/backward
n, N:                    repeat last search and search forward/backward
*, #:                    search forward/backward for the word or selection under the cursor
f, F:                    jump forward/backward to the given character
t, T:                    jump forward/backward to before the given character
; or r                   repeat previous f, t, F or T movement and move forward
, or R                   repeat previous f, t, F or T movement and move backward
v:                       toggle selection mode
V:                       toggle line selection mode
S:                       toggle regular/rectangular selection type
s:                       from move mode switch to flash mode
Z, X:                    jump to previous/next shell prompt that contains the OSC "133;A" sequence
0 - 9:                   set the quantifier
Y:                       yank (copy) selected text
y,Return:                  quit keyboard_select, yank and keep the highlight of the selection
Escape, q:               quit keyboard_select/exit input mode/exit selection mode/reset quantifier
```

st-sx is a fork of suckless' [st terminal](https://st.suckless.org/) that aims to provide the best sixel support for st users. It also includes many useful patches such as ligatures and text reflow.

## Screenshot

![1](https://github.com/veltza/st-sx/assets/106755522/0ec5f614-07fc-4843-8455-1a0020e0a0e7)

Sixels inside a [tmux](https://github.com/tmux/tmux) session (apps: [lsix](https://github.com/hackerb9/lsix) and [vv](https://github.com/hackerb9/vv))

## Patches

- Alpha focus highlight
- Anysize simple
- Blinking cursor
- Bold is not bright
- Boxdraw
- Clipboard
- CSI 22 23
- Dynamic cursor color
- Font2
- Fullscreen
- Hidecursor
- Keyboard select
- Ligatures
- Netwmicon
- Newterm
- Openurlonclick
- Scrollback-reflow
- Sixel
- Swapmouse
- Sync
- Undercurl
- Vertcenter
- Wide glyphs
- Workingdir
- Xresources

## Dependencies

Arch:

```
sudo pacman -S libx11 libxft imlib2 gd
```

Ubuntu:

```
sudo apt install libx11-xcb-dev libxft-dev libimlib2-dev libgd-dev libharfbuzz-dev
```

You don't have to install `libharfbuzz-dev`, if you don't use ligatures. Edit config.h and config.mk to disable ligatures.

## Installation

Clone the repo and run `make`:

```
git clone https://github.com/veltza/st-sx
cd st-sx
make
```

Edit `config.h` and add your favorite fonts, colors etc. and install:

```
sudo make install
```

The executable name is `st`.

You can also configure st-sx via Xresources. See xresources-example file.

## Known issues

- Sixels work inside tmux, but...
  * ...sixels are not enabled in the release version of tmux. You have to compile it yourself with `./configure --enable-sixel`.
  * ...some sixels don't show up. The maximum size of sixels in tmux is 1 MB. You can increase the size limit by changing `INPUT_BUF_LIMIT` in `tmux/input.c`.
  * ...sixels may disappear or get stuck. The reason is that the sixel implementation in tmux is not robust yet.

## Thanks

- [suckless.org](https://suckless.org/) and [st](https://st.suckless.org/) contributors
- Bakkeby's [st-flexipatch](https://github.com/bakkeby/st-flexipatch)
