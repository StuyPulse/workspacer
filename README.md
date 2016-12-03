# Setup

## Setting up this repo

To set up an instance of this project:

    $ touch round2/users.csv
    $ mkdir round2/their-work
    $ ln -s /path/to/repo/round2 ~/round2
    $ ln -s /path/to/repo/client2 ~/client2

And the necessary libraries must be in `~/workspace-libs` (jfxrt.jar and other amd files).
These exist on the `robotics` user account.

## Setting up machines in lab

`copy-docs-all.sh` will copy the Java SE 8 API docs to all machines in rm. 451
which do not have them (at `/var/tmp/javase8-api`).

    $ bash copy-docs-all.sh

`setup-all.sh` copies necessary libraries for JavaFX to the machines that do
not have them (at `/var/tmp/robo-libs`), and updates the necessary plaintext
files on all machines.

    $ bash setup-all.sh

Between meetings (preferably at the end of each meeting, for security's sake),
`make-ssh.sh` should be run:

    $ bash make-ssh.sh
    $ bash setup-all.sh

After running `make-ssh.sh`, `setup-all.sh` *must* be run
again in order for the students to work.

