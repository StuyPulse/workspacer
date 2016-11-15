rm -rf ~/client2/.ssh
mkdir ~/client2/.ssh
# Make rsa key pair with no password (hence -N "")
ssh-keygen -t rsa -f ~/client2/.ssh/id_rsa -N ""

# Make an authorized_keys file (named authed-keys) authorizing the new
# key (from client2, which will be on guest accounts), and also our own key
cp ~/client2/.ssh/id_rsa.pub authed-keys
cat ~/.ssh/id_rsa.pub >> authed-keys

# Place that file in .ssh/authorized_keys on robotics-entry
ssh robotics-entry@localhost "mkdir -p ~/.ssh"
scp authed-keys robotics-entry@localhost:~/.ssh/authorized_keys

rm authed-keys
