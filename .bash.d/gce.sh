# This script requires jq
# sudo apt install jq
# sudo yum install jq

# Assume a GCP CLI configuration set
gce() {

    case $1 in
        i | init) # Create gcp configuration set
            gcloud init
            ;;
        l | load)  # Load a gcp configuration set
            PROFILES=$(gcloud config configurations list --format json | jq -r '.[].name')
            select PROFILE in $PROFILES; do
                gcloud config configurations activate $PROFILE
                break
            done
        ;;
        s | show)  # Show the currently loaded configuration set
            gcloud config list
        ;;
        d | deactivate)  # Deactivate the active configuration set
            rm ~/.config/gcloud/active_config
            ;;
        * )  # Else print help
            echo ""
            echo "  gce [ init | load | show | deactivate ]"
            echo ""
            echo "  gce is a tool for quickly switching between GCP cli configuration sets."
            echo ""
            echo "    i | init )"
            echo "      Create gcp configuration set."
            echo ""
            echo "    l | load )"
            echo "      Load a gcp configuration set."
            echo "      Gives a selection of configuration sets."
            echo ""
            echo "    s | show )"
            echo "      Shows the currently loaded configuration set."
            echo ""
            echo "    d | deactivate )"
            echo "      Deactivate the active configuration set."
            echo ""

    esac
}
