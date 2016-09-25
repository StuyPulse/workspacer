# $1 must be user workspace directory
# $2 must be user's username

if [ -z $1 ]; then
    echo "No arguments given. First argument must be path to the edu-workspace directory"
    exit 1
fi
if [ -z $2 ]; then
    echo "Only one argument given. Second argument must be username"
    exit 1
fi

# Clean their-work/<uname> directory
rm -rf ./their-work/$2/

# Repopulate it with updated work
cp -r $1 ./their-work/$2

# gui.jar doesn't need to be saved for each user
rm ./their-work/$2/lib/gui.jar
