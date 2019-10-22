# save this file under ~/.bash_aliases and add this to your bashrc when it isnt present yet. 
# 
# if [ -f ~/.bash_aliases ]; then
# . ~/.bash_aliases
# fi

# dependencys: 
# net-tools, exa, bat, youtube-dl, ffmpeg, ffmpeg-libs, tmux


# get an random Joke
curl -s "http://api.icndb.com/jokes/random" | jq '.value.joke'


# loads env variables example https://raw.githubusercontent.com/Underknowledge/.bashrc/master/.bash_secrets
if [ -f ~/.bash_secrets ]; then
    . ~/.bash_secrets
fi


# loades an file based on your hostname 
if [ -f ~/.bash_"$(hostname)" ]; then
    . ~/.bash_"$(hostname)"
fi



#alias pull_bash_alias='curl -s $BASHALIASURL -o ~/.bash_aliases  && chmod 600 ~/.bash_aliases' 
#alias pull_bash_secret='curl -s $BASHSEURL  -o ~/.bash_secrets  && chmod 600 ~/.bash_secrets'

alias PUSH_BASH_alias="sftp -oPort=$INTEL_VM_PORT -i ~/.ssh/fs.key fs@$INTEL_VM_ADRESS:/sshfs/setups/bash/ <<< $'put ~/.bash_aliases'"
alias PUSH_BASH_secret="sftp -oPort=$INTEL_VM_PORT -i ~/.ssh/fs.key fs@$INTEL_VM_ADRESS:/sshfs/setups/bash/ <<< $'put ~/.bash_secrets'"
alias PUSH_BASH_host="sftp -oPort=$INTEL_VM_PORT -i ~/.ssh/fs.key fs@$INTEL_VM_ADRESS:/sshfs/setups/bash/ <<< $'put ~/.bash_"$(hostname)"'"

alias BASHHOST='nano ~/.bash_"$(hostname)"'
alias BASHRC='nano ~/.bash_aliases'

alias BASHNOTES="sftp -oPort=$INTEL_VM_PORT -i ~/.ssh/fs.key fs@$INTEL_VM_ADRESS:/sshfs/setups/bash/.bash_notes $FIXEDPATH/.bash_notes;nano ~/.bash_notes;sftp -oPort=$INTEL_VM_PORT -i ~/.ssh/fs.key fs@$INTEL_VM_ADRESS:/sshfs/setups/bash/ <<< $'put $FIXEDPATH/.bash_notes'"
alias PULL_BASH_alias="sftp -oPort=$INTEL_VM_PORT -i ~/.ssh/fs.key fs@$INTEL_VM_ADRESS:/sshfs/setups/bash/.bash_aliases ~/.bash_aliases && chmod 600 ~/.bash_aliases"
alias PULL_BASH_secret="sftp -oPort=$INTEL_VM_PORT -i ~/.ssh/fs.key fs@$INTEL_VM_ADRESS:/sshfs/setups/bash/.bash_secrets ~/.bash_secrets && chmod 600 ~/.bash_secrets"

## alias PULL_BASH_notes="sftp -oPort=$INTEL_VM_PORT -i ~/.ssh/fs.key fs@$INTEL_VM_ADRESS:/sshfs/setups/bash/.bash_notes ~/.bash_notes && chmod 600 ~/.bash_notes"


#-------------------------------------------------------------
# Base System 
#-------------------------------------------------------------

alias please='sudo'
alias ffs='sudo $( fc -ln -1 )'
alias fstab='sudo nano /etc/fstab'

alias listen="lsof -P -i -n" 
alias show-port='netstat -tulanp'

alias sshconfig='nano ~/.ssh/config'
alias update-debian='sudo apt-get update && sudo apt-get upgrade -y'
alias update-arch='sudo pacman -Syy && sudo pacman -Su -y' 
alias bashrc='sudo nano ~/.bashrc'
alias bashalias='sudo nano ~/.bash_aliases'

alias reloadbashrc='exec bash'


#Global aliases (allows you do stuff like alias G <something> instead of alias | grep <something>) 
alias C='|wc -l'
alias G='|grep'
alias H='|head'
alias L='|less'
alias S='|sort'
alias SL='|sort|less'
alias T='|tail'

# Replacing cat and ls with Rust alternatives:
alias cat='bat --paging=never --style=plain'
alias l='exa -1a'
alias la='ls -a'
alias ll='exa -lh --git'
alias ls=exa
alias lt='exa -lT --git'

# random 
alias create_nanorc='find /usr/share/nano -name '*.nanorc' -printf "include %p\n" > ~/.nanorc'


#-------------------------------------------------------------
# Simple docker 
#-------------------------------------------------------------

# Remove all the <none> images. Even though it is not recommended.
alias fl_docker_remove_dangling='docker rmi $(docker images -f dangling=true -q)'

# Stop all running docker containers.
alias fl_docker_stop_all='docker stop $(docker ps -aq)'

# Kill all running containers.
alias fl_docker_kill_containers='docker kill $(docker ps -q)'

# Delete all stopped containers: 'docker rm $(docker ps -a -q)'
alias fl_docker_clean_containers='docker container prune'

# Delete all saved images:  'docker rmi $(docker images -q)'
alias fl_docker_clean_images='docker image prune'

# Delete all containers and images
alias fl_docker_clean_all='docker system prune'

# Restart all containers
alias fl_docker_restart_all='docker restart $(docker ps -a -q)'

# Start all stopped containers:
alias fl_docker_restart_stopped='docker start $(docker ps -a -q -f status=exited)'

alias dcc='docker-compose'
alias doc-ls='docker ps -a'


# linuxserver.io
alias dockeryaml='sudo nano /opt/docker-compose.yml'
alias dcp='docker-compose -f /opt/docker-compose.yml '
alias dcpup='docker-compose -f /opt/docker-compose.yml --compatibility up -d'
alias dcpull='docker-compose -f /opt/docker-compose.yml pull --parallel'
alias dclogs='docker-compose -f /opt/docker-compose.yml logs -tf --tail="50" '
alias dtail='docker logs -tf --tail="50" "$@"'



#usage: docker-shell + ID
docker-shell () {
  if [ $# -eq 0 ]; then
    echo "\$ $FUNCNAME Container_ID"
    docker ps --format '{{.ID}} --- {{.Names}}'
    return 1
  fi
  if [ $# -eq 1 ]; then
    docker exec -it $1 /bin/bash
  fi
  if [ $# -eq 2 ]; then
    docker exec -it $1 $2
  fi
}


#-------------------------------------------------------------
# App Specific Aliases 
#-------------------------------------------------------------


alias youtube-dl-mp3="youtube-dl -x --audio-format mp3 "
alias youtube-dl-playlist="youtube-dl -cio '%(autonumber)s-%(title)s.%(ext)s' "
alias yt="youtube-dl -f 'bestvideo[height<=720]+bestaudio/best[height<=720]'"


alias whatsmyip='curl ifconfig.co'

alias serve="python3.7 -m http.server 8080 --bind $(ip addr | grep -Po '(?!(inet 127.\d.\d.1))(inet \K(\d{1,3}\.){3}\d{1,3})' )"

alias ta="tmux attach -t"
alias tmux0='tmux attach-session -t 0'
alias ts="tmux new-session -s"
alias tl="tmux list-sessions"
alias tmus='tmux new-session -A -D -s music "$(which cmus)"'



#usage: deletes line x out of the known hosts
knownhosterror () {
sed -i " $1 d " ~/.ssh/known_hosts
}



doesitrun () {
ps aux | grep $1
}



function dock()
{
  if [ "$1" == "-h" ]
  then
    printf  "Accepts container name or id, or attach to first running process \n"
  elif [ $# -eq 0 ]
  then
    echo "$(docker ps -q)"
    echo "sudo docker exec -i -t ID_ /bin/bash" 
  elif [ "$1" != "-h" ]
  then
    sudo docker exec -i -t $1 /bin/bash
  fi
}







# Takes a video and converts it to mp4 for web
# usage: genwebmp4 path/to/video.ext
# ffmpeg can handle many ext type so you are not limited (.mov, .avi and so on)
genwebmp4 () {
    ffmpeg -i $1 -vcodec h264 -acodec aac -strict -2 $2
}


# Takes a video and converts it to webm for web
# usage: genwebm path/to/video.ext
# ffmpeg can handle many ext type so you are not limited (.mov, .avi and so on)
genwebm () {
    ffmpeg -i $1 -c:v libvpx-vp9 -b:v 2M -pass 1 -c:a libopus -f webm /dev/null && \
        ffmpeg -i $1 -c:v libvpx-vp9 -b:v 2M -pass 2 -c:a libopus $2
}

#usage: genvideothumb path/to/video.ext
genvideothumb () {
    ffmpeg -ss 00:00:01  -i $1 -vframes 1 -q:v 2 $2
}

# for those who struggle spelling! This will take your best guess and give you a list of what you probably meant.
#usage: spl paranoya 
# & paranoya 8 0: paranoia, Parana, paranoiac (as you see the first option after the 0, gives the correct spelling
spl () {
    aspell -a <<< "$1"
}

#Clean up your git branches that have already been merged in.
#usage: best to first do a git fetch --all and then run gitCleanBranches
gitCleanBranches() {
    git branch --merged | egrep -v "(^\*|master|develop)" | xargs git branch -d
}

#usage: wavToMp3 path/to/file
# no extension needed
wavToMp3() {
    ffmpeg -i $1.wav -codec:a libmp3lame -qscale:a 2 $1.mp3
}


#usage: mp3ToOgg path/to/mp3's
# no extension needed
mp3ToOgg() {
    for file in *.mp3
        do ffmpeg -i "${file}" "${file/%mp3/ogg}"
    done
}
