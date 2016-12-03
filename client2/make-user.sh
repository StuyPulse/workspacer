# Runs as guest user

echo "Hello! You will be making a new user."

echo "Hit Ctrl-C at any point to exit."

# Bind space to no-op
set -o emacs
nospaces="No spaces in username\n"
bind -x "\" \":'echo -en \"$nospaces\"'"
bind -r "\C-V" # By default, C-V allows literal insertion of chars
read -rep "Username: " uname

uname=$(echo "$uname" | tr '[:upper:]' '[:lower:]')

sshcmd="ssh robotics-entry@localhost"

round2path="/home/students/2019/robotics/round2"

if [[ $($sshcmd $round2path/isUserTaken) == "taken" ]]; then
    echo "That username is taken!"
    exit 1
fi

read -rsp "Password: " pass1

echo ""

read -rsp "Confirm password: " pass2

echo ""

if [[ "$pass1" == "$pass2" ]]; then
    if [[ $($sshcmd "cd $round2path; ./addUser \"$uname\" \"$pass1\"") == failure ]]; then
        echo "User creation failed! Try again"
    else
        echo "Created your user!"

        # Copy default workspace to home directory:
        $sshcmd "cd $round2path; tar cf - workspace-template" | tar xf -
        mv workspace-template workspace
        chmod +r ~/workspace

        # Save default workspace to their-work (and set permissions):
        $sshcmd "cd $round2path && cp -r workspace-template \"their-work/$uname\" && chmod -R g+rw \"their-work/$uname\" && chown -R :robogroup \"their-work/$uname\""

        # Update /var/tmp/robo-user-homedir
        $sshcmd "echo $HOME > /var/tmp/robo-user-homedir"

        echo -e "Type\n  cd workspace\nto enter your workspace"
    fi
else
    echo "Passwords did not match! Try again. You can press up arrow to repeat the last command."
fi
