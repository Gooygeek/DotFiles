# This script requires jq
# sudo apt install jq
# sudo yum install jq


# TODO: Better dectection of 24 hours.
#          Currently runs indefintaly
#          What happens when the computer goes to sleep?

aws-creds-deamon() {

    # Becuase this function can run in the background and finding the process to kill it or determine if it is currently running might be tricky, this file is used to confirm if it is running and if deleted early will terminate this deamon
    touch ~/.aws-creds/running

    trap "" HUP   # script will ignore HANGUP signal

    echo "Deamon started at $(date)" >> ~/.aws-creds/log

    while [ 1 -eq 1 ]
    do
        if [ -f "~/.aws-creds/running" ]
        then
            for PROFILE in $(ls ~/.aws-creds/profiles/)
            do
                echo "$PROFILE" >> ~/.aws-creds/log
                res="$(cat ~/.aws-creds/profiles/$PROFILE)"

                export AWS_ACCESS_KEY_ID=`echo $res | jq -r '.Credentials.AccessKeyId'`
                export AWS_SECRET_ACCESS_KEY=`echo $res | jq -r '.Credentials.SecretAccessKey'`
                export AWS_SESSION_TOKEN=`echo $res | jq -r '.Credentials.SessionToken'`
                export AWS_REGION=`aws configure get region --profile $PROFILE`

                res=`aws sts assume-role --role-arn $(aws configure get $PROFILE.role_arn) --role-session-name my_profile_session --profile $PROFILE`
                echo "$res" >| ~/.aws-creds/profiles/$PROFILE
            done
            sleep 30m
            # sleep 30s

        else
            # If running file does not exist, then kill the deamon and delete the tmp cred files
            echo "Deamon stopping at $(date)" >> ~/.aws-creds/log
            rm -r ~/.aws-creds/profiles/
            break

        fi
    done
}


# Assume a role/profile and export the creds to environment variables
aws-creds() {

    case $1 in
        a | activate)  # Acticvate deamon
            mkdir ~/.aws-creds/ &> /dev/null  # Create the tool dir
            mkdir ~/.aws-creds/profiles/ &> /dev/null  # Create the cred dir
            aws-creds-deamon &  # Start the deamon and send to background
            ;;
        l | load)  # Load an AWS profile

            # awk 1 = The seperator is everything between ']' and '['. Therefore, only what is inside the square brackets are piped on.
            #    This will therefore return a list of 'profile <profile>'. (except the first line, which would be 'default').
            # awk 2 = If the line is greater than 1 (i.e. not the first line), then print the second item.
            #    This therefore prints all and only the roles that can be assumed
            PROFILES=$(awk -F"\\\]|\\\[" '/^\[/{print $2}' ~/.aws/config | awk '{if(NR>1)print $2}')

            # This provides a multiple choice method of selecting a profile.
            #    The role will then be assumed and the resulting creds will be exported to the environment varibles
            select PROFILE in $PROFILES; do

                if [ -f "~/.aws-creds/profiles/$PROFILE" ]  # if auto-rotated creds exist, load; else create
                then
                    res="$(cat ~/.aws-creds/profiles/$PROFILE)"
                    export AWS_ACCESS_KEY_ID=`echo $res | jq -r '.Credentials.AccessKeyId'`
                    export AWS_SECRET_ACCESS_KEY=`echo $res | jq -r '.Credentials.SecretAccessKey'`
                    export AWS_SESSION_TOKEN=`echo $res | jq -r '.Credentials.SessionToken'`
                    export AWS_REGION=`aws configure get region --profile $PROFILE`

                else
                    res=`aws sts assume-role --role-arn $(aws configure get $PROFILE.role_arn) --role-session-name my_profile_session --profile $PROFILE`
                    echo "$res" >| ~/.aws-creds/profiles/$PROFILE
                    export AWS_ACCESS_KEY_ID=`echo $res | jq -r '.Credentials.AccessKeyId'`
                    export AWS_SECRET_ACCESS_KEY=`echo $res | jq -r '.Credentials.SecretAccessKey'`
                    export AWS_SESSION_TOKEN=`echo $res | jq -r '.Credentials.SessionToken'`
                    export AWS_REGION=`aws configure get region --profile $PROFILE`

                fi

                export AWS_CREDS_PROFILE=$PROFILE

                break
            done
            ;;
        r | reload)  # Reload auto-rotated creds for most recent profile
            PROFILE=$AWS_CREDS_PROFILE
            res=`aws sts assume-role --role-arn $(aws configure get $PROFILE.role_arn) --role-session-name my_profile_session --profile $PROFILE`
            echo "$res" >| ~/.aws-creds/profiles/$PROFILE
            export AWS_ACCESS_KEY_ID=`echo $res | jq -r '.Credentials.AccessKeyId'`
            export AWS_SECRET_ACCESS_KEY=`echo $res | jq -r '.Credentials.SecretAccessKey'`
            export AWS_SESSION_TOKEN=`echo $res | jq -r '.Credentials.SessionToken'`
            export AWS_REGION=`aws configure get region --profile $PROFILE`
            ;;
        s | show)  # Show the currently loaded profile
            PROFILE=$AWS_CREDS_PROFILE
            echo "Currently loaded profile: ${$PROFILE}"
            echo "Credentials:"
            echo "AWS_ACCESS_KEY_ID = ${AWS_ACCESS_KEY_ID}"
            echo "AWS_SECRET_ACCESS_KEY = ${AWS_SECRET_ACCESS_KEY}"
            echo "AWS_SESSION_TOKEN = ${AWS_SESSION_TOKEN}"
            echo "AWS_REGION = ${AWS_REGION}"
            echo ""
            echo "Note: The details above are taken from your environment variables; if you have manally exported credentials then the api keys might not match the profile."
            ;;

        * )  # Else print help
            echo ""
            echo "  aws-creds [ activate | reload | load ]"
            echo ""
            echo "  aws-creds is a tool for quickly switching between AWS cli profiles."
            echo "  It exports the credentials into environment variables for easy use with most AWS tools."
            echo "  It has an auto rotate function which can run in the background and rotate the temporary credentials."
            echo "  The rotation is done every 30 min to avoid needing to enter an MFA token again (temp creds making temp creds)."
            echo "  The credentials are also saved to disk temporarily which enables quick switching between profiles without needing to reenter an MFA token"
            echo "  Note that some intrusion detection tools might look for temp creds making temp creds and consider this a breach."
            echo ""
            echo "    l | load )"
            echo "      Load a profile."
            echo "      Gives a selection of profiles configured in the users AWS cli config file."
            echo "      If an auto-rotated credential exists for that profile, use that."
            echo ""
            echo "  Options:"
            echo "    a | activate )"
            echo "     Activate the auto-rotate deamon."
            echo "      This will run until the computer is restarted."
            echo ""
            echo "    r | reload )"
            echo "      Load the auto-rotated creds of the most recent profile of the current shell session."
            echo ""
            echo "    s | show )"
            echo "      Shows the currently loaded profile."
            echo ""

    esac
}