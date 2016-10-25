# Runs as guest user

uname=$1
HOSTNAME=localhost

echo "Hello! You will be logging in and getting you work from last time."

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

ssh "robotics-entry@${HOSTNAME}" "cd /home/students/2019/robotics/round2/their-work && tar cf - $uname" | tar xf -

mv $uname workspace

if [[ "$output" == bad-credentials ]]; then
    echo "Username and password did not match."
else
#elif [[ "$output" == success ]]; do
    echo "Logged you in!"
    echo -e "\nType\n  cd workspace\nto enter your workspace"
fi
