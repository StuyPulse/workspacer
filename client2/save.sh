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

#tar cf - workspace | ssh "robotics-entry@${HOSTNAME}" "cd /home/students/2019/robotics/round2 && ./save-workspace.sh"
# ^ ./save-workspace.sh will be difficult. SUID shouldn't work right on it. Perhaps SUID on C executable which runs it thru sh.

workspacedir="$HOME/workspace"

output=$(ssh robotics-entry@${HOSTNAME} "cd $round2path && ./saveWork $workspacedir $uname $pass")

echo "did output"

if [[ "$output" == bad-credentials ]]; then
    echo "Username and password did not match."
else
#elif [[ "$output" == success ]]; do
    echo "Successfully saved your data!"
fi
