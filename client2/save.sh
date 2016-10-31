# Runs as guest user

echo "Hello! You will be saving your workspace."

echo "Hit Ctrl-C at any point to exit."

echo -n "Username: "

read uname

HOSTNAME=localhost
sshcmd="ssh robotics-entry@${HOSTNAME}"

round2path="/home/students/2019/robotics/round2"

if [[ $($sshcmd $round2path/isUserTaken) -ne "taken" ]]; then
    echo "There is no user named \"$uname\"."
    exit 1
fi

echo -n "Password: "

read -s pass

echo ""

workspacedir="$HOME/workspace"

if [[ ! -d "$workspacedir" ]]; then
    echo "You have no workspace to save. Perhaps you want to login. The command"
    echo " $ login"
    echo "will log you in so you can see your work."
    exit 1
fi

output=$(ssh robotics-entry@${HOSTNAME} "cd $round2path && ./saveWork $workspacedir $uname $pass")

if [[ "$output" == bad-credentials ]]; then
    echo "Username and password did not match."
else
#elif [[ "$output" == success ]]; do
    echo "Successfully saved your data!"
fi
