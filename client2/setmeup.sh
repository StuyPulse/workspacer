# Give them today's ssh keys
rm -rf ~/.ssh.bak
if [[ -d ~/.ssh ]]; then
    mv ~/.ssh ~/.ssh.bak
fi
cp -r /var/tmp/robo/.ssh ~/.ssh
chmod go-r ~/.ssh/id_rsa

# Mwa ha haa! No this is just so we can save their work later:
chmod o+rx ~


echo "alias make-user='/var/tmp/robo/make-user.sh'" >> ~/.bash_aliases
echo "alias save='/var/tmp/robo/save.sh'" >> ~/.bash_aliases
echo "alias login='/var/tmp/robo/restore.sh'" >> ~/.bash_aliases

round2path=/home/students/2019/robotics/round2

echo -e "Say 'yes' to the following prompt:\n"

ssh robotics-entry@localhost "ls $round2path/their-work" > ~/.robo-user-list

# Create link to java API docs on desktop
cd ~/Desktop
ln -s /var/tmp/robo-files/JavaDocs.html JavaDocs.html
ln -s /var/tmp/robo-files/lessons.html lessons.html

echo "" # visual separation after SSH stuff
echo "You're all set up! (If there were errors above, ask for help.)"
echo "To start work, close this window and open up a new terminal by hitting Ctrl+Alt+T"
echo "Then, you can log in with the"
echo " $ login"
echo "command, or make a new user with the
echo " $ make-user"
echo "command."
