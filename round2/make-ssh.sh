rm -rf ~/client2/.ssh
mkdir ~/client2/.ssh
# Make rsa key pair with no password (-N "" sets password to empty string)
ssh-keygen -t rsa -f ~/client2/.ssh/id_rsa -N ""

echo -e "Removed client/.ssh and replaced it with new key.\n"

# Make an authorized_keys file ("authed-keys") authorizing the new
# key (from client2), and also our own key
cp ~/client2/.ssh/id_rsa.pub authed-keys
cat ~/.ssh/id_rsa.pub >> authed-keys

echo "Overwriting authorized_keys on robotics-entry to accept only"
echo -e "the key just created in client2 and the key of this user...\n"

# Overwrite .ssh/authorized_keys on robotics-entry with the new authorized keys
ssh robotics-entry@localhost "mkdir -p ~/.ssh"
scp authed-keys robotics-entry@localhost:~/.ssh/authorized_keys

rm authed-keys
