# nnn file manager config
export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"
export NNN_COLORS='#0a1b2c3d;4444'
BLK="04"
CHR="04"
DIR="04"
EXE="00"
REG="00"
HARDLINK="00"
SYMLINK="06"
MISSING="00"
ORPHAN="01"
FIFO="0F"
SOCK="0F"
OTHER="02"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
export NNN_FIFO=/tmp/nnn.fifo
export NNN_PLUG='c:cdpath;d:diffs;f:finder;o:fzopen;p:preview-tui;t:nmount;v:imgview;z:autojump'

# bookmarked directories in CDPATH
export CDPATH="${XDG_CACHE_HOME:-$HOME/.cache}/nnn/bookmarks"

