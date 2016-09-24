if [ -z $1 ]; then
    echo "No argument given. First argument must be path to the workspace directory to be created and populated"
    exit 1
fi

cp -r /home/wilson/694/workspacing/workspace-template $1

mkdir $1/lib
cp /home/wilson/694/workspacing/gui.jar $1/lib/gui.jar
