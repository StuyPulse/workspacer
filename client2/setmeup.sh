# Give them today's ssh keys
rm -rf ~/.ssh
cp -r /var/tmp/robo/.ssh ~/.ssh

# Mwa ha haa! No this is just so we can save their work later:
chmod o+rx ~


echo "alias make-user='/var/tmp/robo/make-user.sh" >> ~/.bash_aliases
echo "alias save='/var/tmp/robo/save.sh" >> ~/.bash_aliases
echo "alias login='/var/tmp/robo/restore.sh'" >> ~/.bash_aliases
