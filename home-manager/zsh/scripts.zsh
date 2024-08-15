#!/usr/bin/env zsh

# custom functions
# symlink
slink() {
    local src_orig=$1
    local dst_link=$2
    local dst_dir=$(dirname "$dst_link")

    # Create the directory if it does not exist
    mkdir -p "$dst_dir"

    # Create the symlink
    ln -nfs "$src_orig" "$dst_link"
}

slink_init() {
    slink $DOTFILES/.Brewfile $HOME/.Brewfile
    slink $DOTFILES/.zshrc $HOME/.zshrc

    slink $DOTFILES_EXPORTS $OMZ_CUSTOM/exports.zsh
    slink $DOTFILES_ALIASES $OMZ_CUSTOM/aliases.zsh
    slink $DOTFILES_FUNCTIONS $OMZ_CUSTOM/functions.zsh

    slink $DOTFILES/nvm/default-packages $NVM_DIR/default-packages
    slink $DOTFILES/.config/git/.gitignore $HOME/.gitignore


    slink $DOTFILES/.config/zellij/main-layout.kdl $HOME/.config/config.kdl
}


# yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}




#############
# TODO
#############

# screenres() {
#     [ ! -z $1 ] && xrandr --current | grep '*' | awk '{print $1}' | sed -n "$1p"
# }

# # Begin a screencast 
# # TODO - To fix (and miss the webcam)
# screencast() {
#     T="$(date +%d-%m-%Y-%H-%M-%S)".mkv
#     if [ $# -gt 0 ]; then
#         if echo $1 | grep '\....$' > /dev/null; then
#             T=$1
#         else
#             T=$1.mkv
#         fi
#     fi

#     # To list cams: v4l2-ctl --list-devices
#     # Record screen 2 by default
#     local screen=2
#     local offset=""
#     local heights=(`screenres 1 | awk -Fx '{print $2}'` `screenres 2 | awk -Fx '{print $2}'`)
#     local bigger_height=$(echo $heights | sed "s/ /\n/" | sort -rg | line 1)

#         [ $screen -eq 1 ] && offset="+0,$(( $bigger_height -  $(screenres 1 | awk -Fx '{print $2}')))"
#         ffmpeg -f x11grab -framerate 60 -s $(screenres $screen) -i :0.0$offset \
#             -f v4l2 -framerate 30 -video_size 640x480 -i /dev/video2 \
#             -f pulse -sample_rate 44100 -i default \
#             -filter_complex "overlay=main_w-overlay_w-2:main_h-overlay_h-2" \
#             -c:v libx264 -preset ultrafast -crf 18 -c:a aac -b:a 320k $T
# }

# oscreencast() {
#     if [ ! -z $1 ]; then
#         ffmpeg -f x11grab -s $(xdpyinfo | grep dimensions | awk '{print $2}') -i :0.0 $1
#     else
#         echo "You need to precise an output file as first argument - eg 'example.mkv'"
#     fi
# }

# # Run script to update Arch and others
# updatesys() {
#     sh $DOTFILES/update.sh
# }

# # Extract files
# extract() {
#     for file in "$@"
#     do
#         if [ -f $file ]; then
#             _ex $file
#         else
#             echo "'$file' is not a valid file"
#         fi
#     done
# }

# # Extract files in their own directories
# mkextract() {
#     for file in "$@"
#     do
#         if [ -f $file ]; then
#             local filename=${file%\.*}
#             mkdir -p $filename
#             cp $file $filename
#             cd $filename
#             _ex $file
#             rm -f $file
#             cd -
#         else
#             echo "'$1' is not a valid file"
#         fi
#     done
# }

# # Internal function to extract any file
# _ex() {
#     case $1 in
#         *.tar.bz2)  tar xjf $1      ;;
#         *.tar.gz)   tar xzf $1      ;;
#         *.bz2)      bunzip2 $1      ;;
#         *.gz)       gunzip $1       ;;
#         *.tar)      tar xf $1       ;;
#         *.tbz2)     tar xjf $1      ;;
#         *.tgz)      tar xzf $1      ;;
#         *.zip)      unzip $1        ;;
#         *.7z)       7z x $1         ;; # require p7zip
#         *.rar)      7z x $1         ;; # require p7zip
#         *.iso)      7z x $1         ;; # require p7zip
#         *.Z)        uncompress $1   ;;
#         *)          echo "'$1' cannot be extracted" ;;
#     esac
# }

# # Compress a file 
# # TODO to improve to compress in any possible format
# # TODO to improve to compress multiple files
# compress() {
#     local DATE="$(date +%Y%m%d-%H%M%S)"
#     tar cvzf "$DATE.tar.gz" "$@"
# }

# # Take a screenshot
# screenshot () {
#     local DIR="$SCREENSHOT"
#     local DATE="$(date +%Y%m%d-%H%M%S)"
#     local NAME="${DIR}/screenshot-${DATE}.png"

#     # Check if the dir to store the screenshots exists, else create it:
#     if [ ! -d "${DIR}" ]; then mkdir -p "${DIR}"; fi

#     # Screenshot a selected window
#     if [ "$1" = "win" ]; then import -format png -quality 100 "${NAME}"; fi

#     # Screenshot the entire screen
#     if [ "$1" = "scr" ]; then import -format png -quality 100 -window root "${NAME}"; fi

#     # Screenshot a selected area
#     if [ "$1" = "area" ]; then import -format png -quality 100 "${NAME}"; fi

#     if [[ $1 =~ "^[0-9].*x[0-9].*$" ]]; then import -format png -quality 100 -resize $1 "${NAME}"; fi

#     if [[ $1 =~ "^[0-9]+$" ]]; then import -format png -quality 100 -resize $1 "${NAME}" ; fi

#     if [[ $# = 0 ]]; then
#         # Display a warning if no area defined
#         echo "No screenshot area has been specified. Please choose between: win, scr, area. Screenshot not taken."
#     fi
# }

# # Spit the size of images
# imgsize() {
#     for file in "$@"
#     do
#         local width=$(identify -format "%w" "$file")> /dev/null
#         local height=$(identify -format "%h" "$file")> /dev/null

#         echo -e "Size of $file: $width*$height"
#     done
# }

# # Resize an image
# # arg1: the file
# # arg2: the width to resize
# # arg3: modify the file in place
# # Example: imgresize myimage.jpg 780 true
# imgresize() {
#     local filename=${1%\.*}
#     local extension="${1##*.}"
#     local separator="_"
#     if [ ! -z $3 ]; then
#         local finalName="$filename.$extension"
#     else
#         local finalName="$filename$separator$2.$extension"
#     fi
#     convert $1 -quality 100 -resize $2 $finalName
#     echo "$finalName resized to $2"
# }

# Imgresize() {
#     imgresize $1 $2 true
# }

# # Resize all images
# # arg1: the extension of all images
# # arg2: the width to resize
# # arg3: modify the files in place
# # Example: imgresizeall jpg 780 true
# imgresizeall() {
#     for f in *.${1}; do
#         if [ ! -z $3 ]; then
#             imgresize "$f" ${2} t
#         else
#             imgresize "$f" ${2}
#         fi
#     done
# }

# imginvert() {
#     local filename=${1%\.*}
#     local extension="${1##*.}"
#     local separator="_"
#     local invert="inverted"
#     if [ ! -z $2 ]; then
#         local finalName="$filename.$extension"
#     else
#         local finalName="$filename$separator$invert.$extension"
#     fi
#     convert $1 -channel RGB -negate $finalName
#     echo "$finalName inverted"
# }

# imgoptimize() {
#     local filename=${1%\.*}
#     local extension="${1##*.}"
#     local separator="_"
#     local suffix="optimized"
#     local finalName="$filename$separator$suffix.$extension"
#     convert $1 -strip -interlace Plane -quality 85% $finalName
#     echo "$finalName created"
# }

# Imgoptimize() {
#     local filename=${1%\.*}
#     local extension="${1##*.}"
#     local separator="_"
#     local suffix="optimized"
#     local convert $1 -strip -interlace Plane -quality 85% $1
#     echo "$1 created"
# }

# imgoptimizeall() {
#     for f in *.${1}; do
#         imgoptimize "$f"
#     done
# }

# Imgoptimizeall() {
#     for f in *.${1}; do
#         Imgoptimize "$f"
#     done
# }

# imgtojpg() {
#     for file in "$@"
#     do
#         local filename=${file%\.*}
#         convert -quality 100 $file "${filename}.jpg"
#     done
# }

# imgtopng() {
#     for file in "$@"
#     do
#         local filename=${file%\.*}
#         convert -quality 100 $file "${filename}.png"
#     done
# }

# imgtowebp() {
#     for file in "$@"
#     do
#         local filename=${file%\.*}
#         cwebp -q 100 $file -o $(basename ${filename}).webp
#     done
# }

# gtrm() {
#     git tag -d $1

#     if [ ! -z "$2" ]; then
#         git push $2 :refs/tags/$1
#     else
#         git push origin :refs/tags/$1
#     fi
# }

# ssh-create() {
#     if [ ! -z "$1" ]; then
#         ssh-keygen -f $HOME/.ssh/$1 -t rsa -N '' -C "$1"
#         chmod 700 $HOME/.ssh/$1*
#     fi
# }

# dback () {
#     if [ ! -z $1 ] && [ ! -z $2 ]; then
#         if [ ! -z $3 ]; then
#             BS=$3
#         else
#             BS="512k"
#         fi

#         dialog --defaultno --title "Are you sure?" --yesno "This will copy $1 to $2 (bitsize: $BS). Everything on $2 will be deleted.\n\n
#         Are you sure?"  15 60 || exit

#         (sudo pv -n $1 | sudo dd of=$2 bs=$BS conv=notrunc,noerror) 2>&1 | dialog --gauge "Backup from disk $1 to disk $2... please wait" 10 70 0
#     else
#         echo "You need to provide an input disk as first argument (i.e /dev/sda) and an output disk as second argument (i.e /dev/sdb)"
#     fi
# }

# blimg() {
#     if [ ! -z $1 ] && [ ! -z $2 ] && [ ! -z $3 ]; then
#         local CYEAR=$(date +'%Y')
#         local BASEDIR="${HOME}/workspace/webtechno/static"
#         #Basedir current year
#         local BASEDIRY="${HOME}/workspace/webtechno/static/${CYEAR}"

#         if [ ! -d $BASEDIRY ]; then
#             mkdir $BASEDIRY
#         fi

#         #basedir current article
#         local BASEDIRC="${BASEDIRY}/${2}"

#         if [ ! -d $BASEDIRP ]; then
#             mkdir $BASEDIRP
#         fi

#         local IMGRESIZED=imgresize "${1} 780"
#         echo "$IMGRESIZED"
#     fi
# }

# postgdump() {
#     local USER="postgres"
#     local HOST="localhost"
#     if [ ! -z $1 ]; then
#         if [ -f "${1}.sql" ]; then
#             rm -i "${1}.sql"
#         fi

#         if [ $# = 1 ]; then
#             pg_dump -c -U $USER -h $HOST $1 | pv --progress > "${1}.sql"
#             echo $1
#         fi

#         if [ $# = 2 ]; then
#             pg_dump -c -U $2 -h $HOST $1 | pv --progress > "${1}.sql"
#             echo $1
#         fi

#         if [ $# = 3 ]; then
#             pg_dump -c -U $2 -h $3 $1 | pv --progress > "${1}.sql"
#             echo $1
#         fi
#     fi

#     if [ $# = 0 ]; then
#         echo "You need at least to provide the database name"
#     fi
# }

# postgimport() {
#     local USER="postgres"
#     local HOST="localhost"
#     if [ ! -z $1 ]; then
#         DB=${1%\.*}
#         # sed -i "1s/^/CREATE DATABASE $DB;\n/" $1
#         if [ $# = 1 ];
#         then
#             pv --progress ${1} | psql -U $USER -h $HOST $1 -d $DB
#             echo $1
#         fi

#         if [ $# = 2 ]; then
#             pv --progress ${1} | psql -U $1 -h $HOST $1 -d $DB
#             echo $1
#         fi

#         if [ $# = 3 ]; then
#             pv --progress ${1} | psql -U $1 -h $2 $1 -d $DB
#             echo $1
#         fi
#     fi

#     if [ $# = 0 ]; then
#         echo "You need at least to provide the database name"
#     fi
# }

# matrix () {
#     local lines=$(tput lines)
#     cols=$(tput cols)

#     awkscript='
#     {
#         letters="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()"
#         lines=$1
#         random_col=$3
#         c=$4
#         letter=substr(letters,c,1)
#         cols[random_col]=0;
#         for (col in cols) {
#             line=cols[col];
#             cols[col]=cols[col]+1;
#             printf "\033[%s;%sH\033[2;32m%s", line, col, letter;
#             printf "\033[%s;%sH\033[1;37m%s\033[0;0H", cols[col], col, letter;
#             if (cols[col] >= lines) {
#                 cols[col]=0;
#             }
#     }
# }
# '

# echo -e "\e[1;40m"
# clear

# while :; do
#     echo $lines $cols $(( $RANDOM % $cols)) $(( $RANDOM % 72 ))
#     sleep 0.05
# done | awk "$awkscript"
# }

# pgdump() {
#     pg_dump -U postgres -h localhost x_loc_0bdf08de > pulsecheck_service_test.sql 
# }

# githeat() {
#     $DOTFILES/bash/scripts/heatmap.sh
# }

# colorblocks() {
#     $DOTFILES/bash/scripts/colorblocks.sh
# }

# colorcards() {
#     $DOTFILES/bash/scripts/colorcards.sh
# }

# colors() {
#     $DOTFILES/bash/scripts/colors.sh
# }

# pipes() {
#     $DOTFILES/bash/scripts/pipes.sh
# }

# smedia() {
#     $DOTFILES/bash/scripts/smedia.sh $@
# }

# mkcd() {
#     local dir="$*";
#     local mkdir -p "$dir" && cd "$dir";
# }

# mkcp() {
#     local dir="$2"
#     local tmp="$2"; tmp="${tmp: -1}"
#     [ "$tmp" != "/" ] && dir="$(dirname "$2")"
#     [ -d "$dir" ] ||
#         mkdir -p "$dir" &&
#         cp -r "$@"
# }

# mkmv() {
#     local dir="$2"
#     local tmp="$2"; tmp="${tmp: -1}"
#     [ "$tmp" != "/" ] && dir="$(dirname "$2")"
#     [ -d "$dir" ] ||
#         mkdir -p "$dir" &&
#         mv "$@"
#     }

# historystat() {
#     history 0 | awk '{print $2}' | sort | uniq -c | sort -n -r | head
# }

# promptspeed() {
#     for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done
# }

# ports() {
#     sudo netstat -tulpn | grep LISTEN | fzf;
# }

# mnt() {
#     local FILE="/mnt/external"
#     if [ ! -z $2 ]; then
#         FILE=$2
#     fi

#     if [ ! -z $1 ]; then
#         sudo mount "$1" "$FILE" -o rw
#         echo "Device in read/write mounted in $FILE"
#     fi

#     if [ $# = 0 ]; then
#         echo "You need to provide the device (/dev/sd*) - use lsblk"
#     fi
# }

# umnt() {
#     local DIRECTORY="/mnt"
#     if [ ! -z $1 ]; then
#         DIRECTORY=$1
#     fi
#     MOUNTED=$(grep $DIRECTORY /proc/mounts | cut -f2 -d" " | sort -r)
#     cd "/mnt"
#     sudo umount $MOUNTED
#     echo "$MOUNTED unmounted"
# }

# mntmtp() {
#     local DIRECTORY="$HOME/mnt"
#     if [ ! -z $2 ]; then
#         local DIRECTORY=$2
#     fi
#     if [ ! -d $DIRECTORY ]; then
#         mkdir $DIRECTORY
#     fi

#     if [ ! -z $1 ]; then
#         simple-mtpfs --device "$1" "$DIRECTORY"
#         echo "MTPFS device in read/write mounted in $DIRECTORY"
#     fi

#     if [ $# = 0 ]; then
#         echo "You need to provide the device number - use simple-mtpfs -l"
#     fi
# }

# umntmtp() {
#     local DIRECTORY="$HOME/mnt"
#     if ; then
#         DIRECTORY=$1
#     fi
#     cd $HOME
#     umount $DIRECTORY
#     echo "$DIRECTORY with mtp filesystem unmounted"
# }

# # Silly little script to understand zstyle
# names() {
#     local user_name user_surname user_nickname computer_name

#     zstyle -s ':name:' set_user_name user_name || user_name="LEELA"
#     zstyle -s ':name:surname:' set_user_name user_surname || user_surname="TURANGA"
#     zstyle -s ':name:nickname::' set_user_name user_nickname || user_nickname="CYCLOPE"
#     zstyle -s ':name:' set_computer_name computer_name || computer_name="BENDER"

#     echo "You're $user_name $user_surname $user_nickname and you're computer is called $computer_name"
# }

# # --restrict-filenames replace special characters like spaces in filenames.
# ydlp() {
#     if ; then
#         youtube-dl --restrict-filenames -f 22 -o "%(autonumber)s-%(title)s.%(ext)s" "$1"
#     else
#         echo "You need to specify a playlist url as argument"
#     fi
# }

# ydl() {
#     if [ ! -z $1 ]; then
#         youtube-dl --restrict-filenames -f 22 -o "%(title)s.%(ext)s" "$1"
#     else
#         echo "You need to specify a video url as argument"
#     fi
# }

# initKondo() {
#     mkdir .clj-kondo
#     clj-kondo --lint "$(boot with-cp -w -f -)"
# }

# vinfo() {
#     vim -c "Vinfo $1" -c 'silent only'
# }

# zshcomp() {
#     for command completion in ${(kv)_comps:#-*(-|-,*)}
#     do
#         printf "%-32s %s\n" $command $completion
#     done | sort
# }

# wav2flac() {
#     for file in "$@"; do
#         local filename=${file%\.*}
#         local extension="${file##*.}"
#         ffmpeg -i "$filename.wav" -af aformat=s32:176000 "$filename.flac"
#     done
# }

# rmwav2flac() {
#     for file in "$@"; do
#         local filename=${file%\.*}
#         local extension="${file##*.}"
#         ffmpeg -i "$filename.wav" -af aformat=s32:176000 "$filename.flac"
#         rm -f $file
#     done
# }

# freetouch() {
#     touch $1.mm
#     cat <<EOF > $1.mm
# <map version="1.0.1">
# <!-- To view this file, download free mind mapping software FreeMind from http://freemind.sourceforge.net -->
# <node TEXT="Title"/>
# </map>
# EOF
# }

# duckduckgo() {
#     lynx -vikeys -accept_all_cookies "https://lite.duckduckgo.com/lite/?q=$@"
# }

# wikipedia() {
#     lynx -vikeys -accept_all_cookies "https://en.wikipedia.org/wiki?search=$@"
# }



# # Count number of words in my blog for a given year
# blogwc() {
#     DATE=$(date +"%Y")
#     if [ ! -z $1 ]; then
#         DATE=$1
#     fi
#     cd ~/workspace/webtechno/content/post && grep -l "date = \"$DATE" *.md | xargs wc && cd -
# }

# cheat() {
#     curl cheat.sh/$1
# }

# touchproject(){
#     if [ -z $1 ];then
#         echo "You need to pass a project name"
#     else
#         local project=$1
#         cd "$CLOUD/project_management/"
#         taskell $project
#         cd -
#     fi
# }

# vimgolf() {
#     local ID=$1
#     local key=$2
#     if [ -z $2 ]; then
#         key=$VIM_GOLF_KEY
#     fi
#     docker run --rm  --net=host -it -e "key=[$VIM_GOLF_KEY]" kramos/vimgolf "$ID"
# }

# fm() {
#     local -r file=$1
#     freemind $file &> /dev/null &
# }

# back() {
#     for file in "$@"; do
#         cp "$file" "$file".bak
#     done
# }

# calcul() {
#     bc -l <<< "$@"
# }

# jrnl() {
#     cd "$JRNL" && vim +Jrnl
# }

# tiny() {
#     local URL=${1:?}
#     curl -s "http://tinyurl.com/api-create.php?url=$1"
# }

# serve() {
#     local -r PORT=${1:-8888}
#     python2 -m SimpleHTTPServer "$PORT"
# }

# kubecfg() {
#     . "$DOTFILES_CLOUD/kubecfg.sh"
# }

# scratchpad() {
#     "$DOTFILES/bash/scripts/scratchpad.sh" "$@"
# }

# git-jump() {
#     "$DOTFILES/bash/scripts/git-jump.sh" "$@"
# }

# # Rename music files automatically depending of their tags (mp3/ogg/flac)
# mvtag() {
#     local option=$1
#     shift

#     lltag --yes "$option" -R --rename-regexp "s/[\'?,\[\]\.\(\):]//" --rename-regexp "s/_-_/-/" --rename-min --rename-sep '_' --rename "%P%n-%t" "$@"
# }

# reposize() {
#   url=`echo $1 \
#     | perl -pe 's#(?:https?://github.com/)([\w\d.-]+\/[\w\d.-]+).*#\1#g' \
#     | perl -pe 's#git\@github.com:([\w\d.-]+\/[\w\d.-]+)\.git#\1#g'
#   `
#   printf "https://github.com/$url => "
#   curl -s https://api.github.com/repos/$url \
#   | jq '.size' \
#   | numfmt --to=iec --from-unit=1024
# }

# # Disable the native keyboard for my TUXEDO laptop
# -keyb() {
#     xinput disable $(xinput list | grep -i "at translated set" | awk '{print $7}' | sed 's/id=//')
# }

# # Enable the native keyboard for my TUXEDO laptop
# keyb() {
#     xinput enable $(xinput list | grep -i "at translated set" | awk '{print $7}' | sed 's/id=//')
# }

# # Enable native pad for my Tuxedo laptop
# pad() {
#     xinput enable $(xinput list | grep -i "touchpad" | awk '{print $6}' | sed 's/id=//')
# }

# # Disable native pad for my Tuxedo laptop
# -pad() {
#     xinput disable $(xinput list | grep -i "touchpad" | awk '{print $6}' | sed 's/id=//')
# }

# # Launch a program in a terminal without getting any output,
# # and detache the process from terminal
# # (can then close the terminal without terminating process)
# -echo() {
#     "$@" &> /dev/null & disown
# }

# # Generate a password - default 20 characters
# pass() {
#     local size=${1:-20}
#     cat /dev/random | tr -dc '[:graph:]' | head -c$size
# }

# # Generate a m3u files with same filename as directories passed as arguments.
# # The file is written with all files in each arg.
# # Example: cm3u Xenogears
# # Create a file 'Xenogears.m3u' and inside for example 'Xenogears/Xenogears The Game.bin'
# cm3u() {
#     for file in "$@"
#     do
#         if [ -d $file ]; then
#             m3u="$file.m3u"
#             find "$file" -type f > "$m3u"
#         else
#             echo "'$file' should be the directory where all your files are"
#         fi
#     done
# }

# backup() {
#     "$DOTFILES/bash/scripts/backup/backup.sh" "-x" "$@" "$DOTFILES_CLOUD/backup/dir.csv"
# }

# # Transfer all ROMS to my rg35xx handheld console
# roms2gb() {
#     "$DOTFILES/bash/scripts/backup/backup.sh" "$@" "$DOTFILES_CLOUD/backup/roms.csv"
#     cp /home/hypnos/Games/emulators/console/nes/roms/hacks/* /run/media/hypnos/ROMS/FC
#     cp /home/hypnos/Games/emulators/console/snes/roms/hacks/* /run/media/hypnos/ROMS/SFC
#     cp /home/hypnos/Games/emulators/console/megadrive/roms/hacks/* /run/media/hypnos/ROMS/MD
#     cp /home/hypnos/Games/emulators/console/gba/roms/hacks/* /run/media/hypnos/ROMS/GBA
#     cp /home/hypnos/Games/emulators/console/gb/roms/hacks/* /run/media/hypnos/ROMS/GB
# }

# gitam() {
#     LC_ALL=C GIT_COMMITTER_DATE="$(date)" git commit --amend --no-edit --date "$(date)"
# }

# pom() {
#     local -r HOURS=${1:?}
#     local -r MINUTES=${2:-0}
#     local -r POMODORO_DURATION=${3:-25}

#     bc <<< "(($HOURS * 60) + $MINUTES) / $POMODORO_DURATION"
# }





# ##########################
# # script FZF
# ##########################

# #!/usr/bin/env zsh

# # +-----+
# # | Git |
# # +-----+

# function fgf() {
# 	local -r prompt_add="Add > "
# 	local -r prompt_reset="Reset > "

# 	local -r git_root_dir=$(git rev-parse --show-toplevel)
# 	local -r git_unstaged_files="git ls-files --modified --deleted --other --exclude-standard --deduplicate $git_root_dir"

# 	local git_staged_files='git status --short | grep "^[A-Z]" | awk "{print \$NF}"'

# 	local -r git_reset="git reset -- {+}"
# 	local -r enter_cmd="($git_unstaged_files | grep {} && git add {+}) || $git_reset"

# 	local -r preview_status_label="[ Status ]"
# 	local -r preview_status="git status --short"

# 	local -r header=$(cat <<-EOF
# 		> CTRL-S to switch between Add Mode and Reset mode
# 		> CTRL_T for status preview | CTRL-F for diff preview | CTRL-B for blame preview
# 		> ALT-E to open files in your editor
# 		> ALT-C to commit | ALT-A to append to the last commit
# 		EOF
# 	)

# 	local -r add_header=$(cat <<-EOF
# 		$header
# 		> ENTER to add files
# 		> ALT-P to add patch
# 	EOF
# 	)

# 	local -r reset_header=$(cat <<-EOF
# 		$header
# 		> ENTER to reset files
# 		> ALT-D to reset and checkout files
# 	EOF
# 	)

# 	local -r mode_reset="change-prompt($prompt_reset)+reload($git_staged_files)+change-header($reset_header)+unbind(alt-p)+rebind(alt-d)"
# 	local -r mode_add="change-prompt($prompt_add)+reload($git_unstaged_files)+change-header($add_header)+rebind(alt-p)+unbind(alt-d)"

# 	eval "$git_unstaged_files" | fzf \
# 	--multi \
# 	--reverse \
# 	--no-sort \
# 	--prompt="Add > " \
# 	--preview-label="$preview_status_label" \
# 	--preview="$preview_status" \
# 	--header "$add_header" \
# 	--header-first \
# 	--bind='start:unbind(alt-d)' \
# 	--bind="ctrl-t:change-preview-label($preview_status_label)" \
# 	--bind="ctrl-t:+change-preview($preview_status)" \
# 	--bind='ctrl-f:change-preview-label([ Diff ])' \
# 	--bind='ctrl-f:+change-preview(git diff --color=always {} | sed "1,4d")' \
# 	--bind='ctrl-b:change-preview-label([ Blame ])' \
# 	--bind='ctrl-b:+change-preview(git blame --color-by-age {})' \
# 	--bind="ctrl-s:transform:[[ \$FZF_PROMPT =~ '$prompt_add' ]] && echo '$mode_reset' || echo '$mode_add'" \
# 	--bind="enter:execute($enter_cmd)" \
# 	--bind="enter:+reload([[ \$FZF_PROMPT =~ '$prompt_add' ]] && $git_unstaged_files || $git_staged_files)" \
# 	--bind="enter:+refresh-preview" \
# 	--bind='alt-p:execute(git add --patch {+})' \
# 	--bind="alt-p:+reload($git_unstaged_files)" \
# 	--bind="alt-d:execute($git_reset && git checkout {+})" \
# 	--bind="alt-d:+reload($git_staged_files)" \
# 	--bind='alt-c:execute(git commit)+abort' \
# 	--bind='alt-a:execute(git commit --amend)+abort' \
# 	--bind='alt-e:execute(${EDITOR:-vim} {+})' \
# 	--bind='f1:toggle-header' \
# 	--bind='f2:toggle-preview' \
# 	--bind='ctrl-y:preview-up' \
# 	--bind='ctrl-e:preview-down' \
# 	--bind='ctrl-u:preview-half-page-up' \
# 	--bind='ctrl-d:preview-half-page-down'
# }

# function fgc() {
# 	local -r git_log=$(cat <<-EOF
# 		git log --graph --color --format="%C(white)%h - %C(green)%cs - %C(blue)%s%C(red)%d"
# 	EOF
# 	)

# 	local -r git_log_all=$(cat <<-EOF
# 		git log --all --graph --color --format="%C(white)%h - %C(green)%cs - %C(blue)%s%C(red)%d"
# 	EOF
# 	)


# 	local get_hash
# 	read -r -d '' get_hash <<-'EOF'
# 		echo {} | grep -o "[a-f0-9]\{7\}" | sed -n "1p"
# 	EOF

# 	local -r git_show="[[ \$($get_hash) != '' ]] && git show --color \$($get_hash)"
# 	local -r git_show_subshell=$(cat <<-EOF
# 		[[ \$($get_hash) != '' ]] && sh -c "git show --color \$($get_hash) | less -R"
# 	EOF
# 	)

# 	local -r git_checkout="[[ \$($get_hash) != '' ]] && git checkout \$($get_hash)"
# 	local -r git_reset="[[ \$($get_hash) != '' ]] && git reset \$($get_hash)"
# 	local -r git_rebase_interactive="[[ \$($get_hash) != '' ]] && git rebase --interactive \$($get_hash)"
# 	local -r git_cherry_pick="[[ \$($get_hash) != '' ]] && git cherry-pick \$($get_hash)"

# 	local -r header=$(cat <<-EOF
# 		> ENTER to display the diff with less
# 	EOF
# 	)

# 	local -r header_branch=$(cat <<-EOF
# 		$header
# 		> CTRL-S to switch to All Commits mode
# 		> ALT-C to checkout the commit | ALT-R to reset to the commit
# 		> ALT-I to rebase interactively until the commit
# 	EOF
# 	)

# 	local -r header_all=$(cat <<-EOF
# 		$header
# 		> CTRL-S to switch to Branch Commits mode
# 		> ALT-P to cherry pick
# 	EOF
# 	)

# 	local -r reset_header=$(cat <<-EOF
# 		$header
# 		> ENTER to reset files
# 		> ALT-D to reset and checkout files
# 	EOF
# 	)

# 	local -r branch_prompt='Branch > '
# 	local -r all_prompt='All > '

# 	local -r mode_all="change-prompt($all_prompt)+reload($git_log_all)+change-header($header_all)+unbind(alt-c)+unbind(alt-r)+unbind(alt-i)+rebind(alt-p)"
# 	local -r mode_branch="change-prompt($branch_prompt)+reload($git_log)+change-header($header_branch)+rebind(alt-c)+rebind(alt-r)+rebind(alt-i)+unbind(alt-p)"

# 	eval "$git_log" | fzf \
# 		--ansi \
# 		--reverse \
# 		--no-sort \
# 		--prompt="$branch_prompt" \
# 		--header-first \
# 		--header="$header_branch" \
# 		--preview="$git_show" \
# 		--bind='start:unbind(alt-p)' \
# 		--bind="ctrl-s:transform:[[ \$FZF_PROMPT =~ '$branch_prompt' ]] && echo '$mode_all' || echo '$mode_branch'" \
# 		--bind="enter:execute($git_show_subshell)" \
# 		--bind="alt-c:execute($git_checkout)+abort" \
# 		--bind="alt-r:execute($git_reset)+abort" \
# 		--bind="alt-i:execute($git_rebase_interactive)+abort" \
# 		--bind="alt-p:execute($git_cherry_pick)+abort" \
# 		--bind='f1:toggle-header' \
# 		--bind='f2:toggle-preview' \
# 		--bind='ctrl-y:preview-up' \
# 		--bind='ctrl-e:preview-down' \
# 		--bind='ctrl-u:preview-half-page-up' \
# 		--bind='ctrl-d:preview-half-page-down'
# }


# function fgb() {
# 	local -r git_branches="git branch --all --color --format=$'%(HEAD) %(color:yellow)%(refname:short)\t%(color:green)%(committerdate:short)\t%(color:blue)%(subject)' | column --table --separator=$'\t'"
# 	local -r get_selected_branch='echo {} | sed "s/^[* ]*//" | awk "{print \$1}"'
# 	local -r git_log="git log \$($get_selected_branch) --graph --color --format='%C(white)%h - %C(green)%cs - %C(blue)%s%C(red)%d'"
# 	local -r git_diff='git diff --color $(git branch --show-current)..$(echo {} | sed "s/^[* ]*//" | awk "{print \$1}")'
# 	local -r git_show_subshell=$(cat <<-EOF
# 		[[ \$($get_selected_branch) != '' ]] && sh -c "git show --color \$($get_selected_branch) | less -R"
# 	EOF
# 	)
# 	local -r header=$(cat <<-EOF
# 	> ALT-M to merge with current * branch | ALT-R to rebase with current * branch
# 	> ALT-C to checkout the branch
# 	> ALT-D to delete the merged local branch | ALT-X to force delete the local branch
# 	> ENTER to open the diff with less
# 	EOF
# 	)

# 	eval "$git_branches" \
# 	| fzf \
# 		--ansi \
# 		--reverse \
# 		--no-sort \
# 		--preview-label '[ Commits ]' \
# 		--preview "$git_log" \
# 		--header-first \
# 		--header="$header" \
# 		--bind="alt-c:execute(git checkout \$($get_selected_branch))" \
# 		--bind="alt-c:+reload($git_branches)" \
# 		--bind="alt-m:execute(git merge \$($get_selected_branch))" \
# 		--bind="alt-r:execute(git rebase \$($get_selected_branch))" \
# 		--bind="alt-d:execute(git branch --delete \$($get_selected_branch))" \
# 		--bind="alt-d:+reload($git_branches)" \
# 		--bind="alt-x:execute(git branch --delete --force \$($get_selected_branch))" \
# 		--bind="alt-x:+reload($git_branches)" \
# 		--bind="enter:execute($git_show_subshell)" \
# 		--bind='ctrl-f:change-preview-label([ Diff ])' \
# 		--bind="ctrl-f:+change-preview($git_diff)" \
# 		--bind='ctrl-i:change-preview-label([ Commits ])' \
# 		--bind="ctrl-i:+change-preview($git_log)" \
# 		--bind='f1:toggle-header' \
# 		--bind='f2:toggle-preview' \
# 		--bind='ctrl-y:preview-up' \
# 		--bind='ctrl-e:preview-down' \
# 		--bind='ctrl-u:preview-half-page-up' \
# 		--bind='ctrl-d:preview-half-page-down'
# }

# # +--------+
# # | Pacman |
# # +--------+

# # TODO can improve that with a bind to switch to what was installed
# fpac() {
#     pacman -Slq | fzf --multi --reverse --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S
# }

# fyay() {
#     yay -Slq | fzf --multi --reverse --preview 'yay -Si {1}' | xargs -ro yay -S
# }

# # +------+
# # | tmux |
# # +------+

# fmux() {
#     prj=$(find $XDG_CONFIG_HOME/tmuxp/ -execdir bash -c 'basename "${0%.*}"' {} ';' | sort | uniq | nl | fzf | cut -f 2)
#     echo $prj
#     [ -n "$prj" ] && tmuxp load $prj
# }

# # ftmuxp - propose every possible tmuxp session
# ftmuxp() {
#     if [[ -n $TMUX ]]; then
#         return
#     fi

#     # get the IDs
#     ID="$(ls $XDG_CONFIG_HOME/tmuxp | sed -e 's/\.yml$//')"
#     if [[ -z "$ID" ]]; then
#         tmux new-session
#     fi

#     create_new_session="Create New Session"

#     ID="${create_new_session}\n$ID"
#     ID="$(echo $ID | fzf | cut -d: -f1)"

#     if [[ "$ID" = "${create_new_session}" ]]; then
#         tmux new-session
#     elif [[ -n "$ID" ]]; then
#         # Change name of urxvt tab to session name
#         printf '\033]777;tabbedx;set_tab_name;%s\007' "$ID"
#         tmuxp load "$ID"
#     fi
# }

# # ftmux - help you choose tmux sessions
# ftmux() {
#     if [[ ! -n $TMUX ]]; then
#         # get the IDs
#         ID="`tmux list-sessions`"
#         if [[ -z "$ID" ]]; then
#             tmux new-session
#         fi
#         create_new_session="Create New Session"
#         ID="$ID\n${create_new_session}:"
#         ID="`echo $ID | fzf | cut -d: -f1`"
#         if [[ "$ID" = "${create_new_session}" ]]; then
#             tmux new-session
#         elif [[ -n "$ID" ]]; then
#             printf '\033]777;tabbedx;set_tab_name;%s\007' "$ID"
#             tmux attach-session -t "$ID"
#         else
#             :  # Start terminal normally
#         fi
#     fi
# }

# # +-------+
# # | Other |
# # +-------+

# # List install files for dotfiles
# fdot() {
#     file=$(find "$DOTFILES/install" -exec basename {} ';' | sort | uniq | nl | fzf | cut -f 2)
#     [ -n "$file" ] && "$EDITOR" "$DOTFILES/install/$file"
# }

# # List projects
# fwork() {
#     result=$(find ~/workspace/* -type d -prune -exec basename {} ';' | sort | uniq | nl | fzf | cut -f 2)
#     [ -n "$result" ] && cd ~/workspace/$result
# }

# # Open pdf with Zathura
# fpdf() {
#     result=$(find -type f -name '*.pdf' | fzf --bind "ctrl-r:reload(find -type f -name '*.pdf')" --preview "pdftotext {} - | less")
#     [ -n "$result" ] && nohup zathura "$result" &> /dev/null & disown
# }

# # Open epubs with Zathura
# fepub() {
#     result=$(find -type f -name '*.epub' | fzf --bind "ctrl-r:reload(find -type f -name '*.epub')")
#     [ -n "$result" ] && nohup zathura "$result" &> /dev/null & disown
# }

# # Open freemind mindmap
# fmind() {
#     local folders=("$CLOUD/knowledge_base" "$WORKSPACE/alexandria")

#     files=""
#     for root in ${folders[@]}; do
#         files="$files $(find $root -name '*.mm')"
#     done
#     result=$(echo "$files" | fzf -m --height 60% --border sharp | tr -s "\n" " ")
#     [ -n "$result" ] && nohup freemind $(echo $result) &> /dev/null & disown
# }

# # List tracking spreadsheets (productivity, money ...)
# ftrack() {
#     file=$(ls $CLOUD/tracking/**/*.{ods,csv} | fzf) || return
#     [ -n "$file" ] && libreoffice "$file" &> /dev/null &
# }

# # Search and find directories in the dir stack
# fpop() {
#     # Only work with alias d defined as:
    
#     # alias d='dirs -v'
#     # for index ({1..9}) alias "$index"="cd +${index}"; unset index

#     d | fzf --height="20%" | cut -f 1 | source /dev/stdin
# }

# # Find in File using ripgrep
# fif() {
#   if [ ! "$#" -gt 0 ]; then return 1; fi
#   rg --files-with-matches --no-messages "$1" \
#       | fzf --preview "highlight -O ansi -l {} 2> /dev/null \
#       | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' \
#       || rg --ignore-case --pretty --context 10 '$1' {}"
# }

# # Find in file using ripgrep-all
# fifa() {
#     if [ ! "$#" -gt 0 ]; then return 1; fi
#     local file
#     file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$*" \
#         | fzf-tmux -p +m --preview="rga --ignore-case --pretty --context 10 '"$*"' {}")" \
#         && print -z "./$file" || return 1;
# }

# # Search through all man pages
# function fman() {
#     man -k . | fzf -q "$1" --prompt='man> '  --preview $'echo {} | tr -d \'()\' | awk \'{printf "%s ", $2} {print $1}\' | xargs -r man' | tr -d '()' | awk '{printf "%s ", $2} {print $1}' | xargs -r man
# }


