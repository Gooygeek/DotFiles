
# Easily switch between different SSH Keys loaded into the agent
sshk() {
    SSHK_HOME="$HOME/.ssh/sshk-keys"

    case $1 in
        i | init) # Create folders
            mkdir $SSHK_HOME
            ;;
        g | generate) # Create new Key
            read -p "Key Name: " KEYNAME
            read -p "Comment (email): " KEYCOMMENT
            ssh-keygen -f $SSHK_HOME/$KEYNAME -C $KEYCOMMENT
            ;;
        l | load) # Load a particular SSH Key, dropping all existing keys from the agent
            KEYS=$(\ls -1 $SSHK_HOME | grep -v ".pub")

            # This provides a multiple choice method of selecting a key.
            select KEY in $KEYS; do
                ssh-add -D
                ssh-add $SSHK_HOME/$KEY
                break
            done
            ;;
        a | add)  # Add a key to the agent
            KEYS=$(\ls -1 $SSHK_HOME | grep -v ".pub")

            # This provides a multiple choice method of selecting a key.
            select KEY in $KEYS; do
                ssh-add $SSHK_HOME/$KEY
                break
            done
            ;;
        s | show)  # Show the currently loaded keys
            ssh-add -l
            ;;
        c | clear)  # Drop all keys from the agent
            ssh-add -D
            ;;
        r | remove)  # Delete a set of keys

            KEYS=$(\ls -1 $SSHK_HOME | grep -v ".pub")

            # This provides a multiple choice method of selecting a key.
            select KEY in $KEYS; do
                rm $SSHK_HOME/$KEY
                rm $SSHK_HOME/$KEY.pub
                break
            done
            ;;
        * )  # Else print help
            echo ""
            echo "  sshk [ init | generate | load | add | show | clear | remove]"
            echo ""
            echo "  sshk is a tool for quickly switching between SSH Keys loaded into the agent."
            echo ""
            echo "    i | init )"
            echo "      Create folders."

            echo "    g | generate )"
            echo "      Create an SSH Key."
            echo ""
            echo "    l | load )"
            echo "      Drop all existing keys and select a key to load."
            echo ""
            echo "    a | add )"
            echo "      Select a key to add to the agent."
            echo ""
            echo "    s | show )"
            echo "      Shows the currently loaded keys."
            echo ""
            echo "    c | clear )"
            echo "      Drops all keys."
            echo ""
            echo "    r | remove )"
            echo "      Deletes a set of keys."
            echo ""

    esac
}
