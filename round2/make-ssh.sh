rm -rf ~/client2/.ssh
mkdir ~/client2/.ssh
ssh-keygen -t rsa -f ~/client2/.ssh/id_rsa -N ""

# Overwrite authorized_keys with just the new key, on robotics-entry
ssh robotics-entry@localhost "mkdir -p ~/.ssh"
scp ~/client2/.ssh/id_rsa.pub robotics-entry@localhost:~/.ssh/authorized_keys
