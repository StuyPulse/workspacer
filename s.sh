echo "hi from s"
id
chmod -R a+rx newbie-ssh
echo "cp -r newbie-ssh ~ && mv ~/newbie-ssh ~/.ssh" | bash
chmod -R go-rx newbie-ssh

# Running system("./s.sh") (from interface.c) runs s.sh with
# euid permissions of the caller, but running through `bash`
# runs with euid as the uid of the caller. This means this script
# can be run with euid of the owner of newbie-ssh, chmod, copy
# it into ~ with the euid of the original user, and then chmod
# newbie-ssh back. And yes this is insecure.
