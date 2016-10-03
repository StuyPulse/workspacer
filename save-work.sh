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

scp -o BatchMode=yes ~/examples.desktop wilson.berkow@lisa.stuy.edu:examples
echo "did examples.desktop"
scp -o BatchMode=yes -r ./their-work/$2 wilson.berkow@lisa.stuy.edu:/var/tmp/workspacer/their-work/$2

# THE ABOVE WORKED! Had to run an arbitrary scp first tho to say "yes" to add to known hosts
