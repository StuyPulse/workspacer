if [ -z $1 ]; then
    echo "No arguments given. First argument must be path to the edu-workspace directory to be created and populated"
    exit 1
fi
if [ -z $2 ]; then
    echo "Only one argument given. Second argument must be username"
    exit 1
fi

cp -r /home/wilson/workspacing/workspace-template $1
cp -r /home/wilson/workspacing/workspace-template /home/wilson/workspacing/their-work/$2

mkdir $1/lib
cp /home/wilson/workspacing/gui.jar $1/lib/gui.jar
