# $1 must be user workspace directory (including /edu-workspace)
# $2 must be user's username

if [ -z $1 ]; then
    echo "No arguments given. First argument must be path to the edu-workspace directory"
    exit 1
fi
if [ -z $2 ]; then
    echo "Only one argument given. Second argument must be username"
    exit 1
fi

if [ -d $1 ]; then
    echo "Your edu-workspace directory already is here. Cancelling 'restore' operation."
    echo "You may have meant to save. Otherwise, ask the instructor for help."
    exit 1
fi

cp -r ./their-work/$2 $1

ln -s /var/tmp/workspacer/lib $1/lib
