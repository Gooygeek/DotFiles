# This script requires jq
# sudo apt install jq
# sudo yum install jq



# Assume a role/profile and export the creds to environment variables
awse() {

    case $1 in
        i | init) # Create folders
            mkdir $HOME/.aws/cached-creds
            mkdir $HOME/.aws/config-sets
            ;;
        l | load)  # Load an AWS profile

            # awk 1 = The seperator is everything between ']' and '['. Therefore, only what is inside the square brackets are piped on.
            #    This will therefore return a list of 'profile <profile>'. (except the first line, which would be 'default').
            # awk 2 = If the line is greater than 1 (i.e. not the first line), then print the second item.
            #    This therefore prints all and only the roles that can be assumed
            PROFILES=$(awk -F"\\\]|\\\[" '/^\[/{print $2}' $HOME/.aws/config | awk '{if(NR>1)print $2}')

            # This provides a multiple choice method of selecting a profile.
            #    The role will then be assumed and the resulting creds will be exported to the environment varibles
            select PROFILE in $PROFILES; do

                if [ -f "$HOME/.aws/cached-creds/$PROFILE" ]  # if auto-rotated creds exist, load; else create
                then
                    timeSinceLastMod=$(expr $(date +%s) - $(stat -c %Y "$HOME/.aws/cached-creds/$PROFILE"))
                    echo "Time since last cached: ${timeSinceLastMod}"
                    if [ $timeSinceLastMod -gt 3600 ]
                    then
                        read -p "MFA Code: " MFA_CODE
                        res=`aws sts assume-role --role-arn $(aws configure get $PROFILE.role_arn) --role-session-name kgol --profile $(aws configure get $PROFILE.source_profile) --serial-number $(aws configure get $PROFILE.mfa_serial) --token-code $MFA_CODE`
                        echo "$res" >| $HOME/.aws/cached-creds/$PROFILE
                        export AWS_ACCESS_KEY_ID=`echo $res | jq -r '.Credentials.AccessKeyId'`
                        export AWS_SECRET_ACCESS_KEY=`echo $res | jq -r '.Credentials.SecretAccessKey'`
                        export AWS_SESSION_TOKEN=`echo $res | jq -r '.Credentials.SessionToken'`
                        export AWS_REGION=`aws configure get region --profile $PROFILE`

                    else
                        res="$(cat $HOME/.aws/cached-creds/$PROFILE)"
                        export AWS_ACCESS_KEY_ID=`echo $res | jq -r '.Credentials.AccessKeyId'`
                        export AWS_SECRET_ACCESS_KEY=`echo $res | jq -r '.Credentials.SecretAccessKey'`
                        export AWS_SESSION_TOKEN=`echo $res | jq -r '.Credentials.SessionToken'`
                        export AWS_REGION=`aws configure get region --profile $PROFILE`
                    fi

                else
                    read -p "MFA Code: " MFA_CODE
                    res=`aws sts assume-role --role-arn $(aws configure get $PROFILE.role_arn) --role-session-name kgol --profile $(aws configure get $PROFILE.source_profile) --serial-number $(aws configure get $PROFILE.mfa_serial) --token-code $MFA_CODE`
                    echo "$res" >| $HOME/.aws/cached-creds/$PROFILE
                    export AWS_ACCESS_KEY_ID=`echo $res | jq -r '.Credentials.AccessKeyId'`
                    export AWS_SECRET_ACCESS_KEY=`echo $res | jq -r '.Credentials.SecretAccessKey'`
                    export AWS_SESSION_TOKEN=`echo $res | jq -r '.Credentials.SessionToken'`
                    export AWS_REGION=`aws configure get region --profile $PROFILE`

                    #aws-creds-delayed-delete $HOME/.aws/cached-creds/$PROFILE &
                fi

                export AWS_CREDS_PROFILE=$PROFILE
                export AWS_PROFILE=$PROFILE

                break
            done
            ;;
        r | reload)  # Reload creds for most recent profile
            PROFILE=$AWS_CREDS_PROFILE
            read -p "MFA Code: " MFA_CODE
            res=`aws sts assume-role --role-arn $(aws configure get $PROFILE.role_arn) --role-session-name kgol --profile $(aws configure get $PROFILE.source_profile) --serial-number $(aws configure get $PROFILE.mfa_serial) --token-code $MFA_CODE`
            echo "$res" >| $HOME/.aws/cached-creds/$PROFILE
            export AWS_ACCESS_KEY_ID=`echo $res | jq -r '.Credentials.AccessKeyId'`
            export AWS_SECRET_ACCESS_KEY=`echo $res | jq -r '.Credentials.SecretAccessKey'`
            export AWS_SESSION_TOKEN=`echo $res | jq -r '.Credentials.SessionToken'`
            export AWS_REGION=`aws configure get region --profile $PROFILE`
            ;;
        a | assume)  # Assume a given role
            res=`aws sts assume-role --role-arn $2 --role-session-name my_profile_session`
            export AWS_ACCESS_KEY_ID=`echo $res | jq -r '.Credentials.AccessKeyId'`
            export AWS_SECRET_ACCESS_KEY=`echo $res | jq -r '.Credentials.SecretAccessKey'`
            export AWS_SESSION_TOKEN=`echo $res | jq -r '.Credentials.SessionToken'`
            export AWS_REGION=`aws configure get region --profile $PROFILE`
            ;;
        p | prompt ) # Export given creds to env vars
            read -p "Access Key ID = " ACCESSKEYID
            read -p "Secret Access Key = " SECRETACCESSKEY
            read -p "Session Token = " SESSIONTOKEN
            export AWS_ACCESS_KEY_ID=$ACCESSKEYID
            export AWS_SECRET_ACCESS_KEY=$SECRETACCESSKEY
            export AWS_SESSION_TOKEN=$SESSIONTOKEN
            ;;
        s | show)  # Show the currently loaded profile
            PROFILE=$AWS_CREDS_PROFILE
            echo "Currently loaded profile: $PROFILE"
            echo "Caller ID: $(aws sts get-caller-identity)"
            echo "Credentials:"
            echo " export AWS_ACCESS_KEY_ID=\"${AWS_ACCESS_KEY_ID}\""
            echo " export AWS_SECRET_ACCESS_KEY=\"${AWS_SECRET_ACCESS_KEY}\""
            echo " export AWS_SESSION_TOKEN=\"${AWS_SESSION_TOKEN}\""
            echo " export AWS_REGION=\"${AWS_REGION}\""
            ;;
        S |swap)  # Change the currently loaded config & credentials set
            SETS=$(\ls $HOME/.aws/config-sets/)
            select SET in $SETS; do
                cp $HOME/.aws/config-sets/$SET/* $HOME/.aws/
                break
            done
            ;;
        o | open)  # Open the AWS console with the current credentials
            if command -v python3 &> /dev/null
            then
                python3 -m webbrowser "$(python3 ~/.local/bin/aws-creds-to-console.py)"
            else
                echo "Python3 is required to run this function"
            fi
            ;;
        c | clear)  # Delete all current profiles
            touch $HOME/.aws/cached-creds/tmp
            rm $HOME/.aws/cached-creds/*
            unset AWS_ACCESS_KEY_ID
            unset AWS_SECRET_ACCESS_KEY
            unset AWS_SESSION_TOKEN
            unset AWS_REGION
            unset AWS_CREDS_PROFILE
            unset AWS_PROFILE
            rm $HOME/.aws/config
            rm $HOME/.aws/credentials
            ;;
        * )  # Else print help
            echo ""
            echo "  awse [ init | load | reload | assume | prompt | show | swap | open | clear ]"
            echo ""
            echo "  aws-creds is a tool for quickly switching between AWS cli profiles."
            echo "  It exports the credentials into environment variables for easy use with most AWS tools."
            echo "  It has an auto rotate function which can run in the background and rotate the temporary credentials."
            echo "  The rotation is done every 30 min to avoid needing to enter an MFA token again (temp creds making temp creds)."
            echo "  The credentials are also saved to disk temporarily which enables quick switching between profiles without needing to reenter an MFA token"
            echo "  Note that some intrusion detection tools might look for temp creds making temp creds and consider this a breach."
            echo ""
            echo "    i | init )"
            echo "      Create folders."
            echo ""
            echo "    l | load )"
            echo "      Load a profile."
            echo "      Gives a selection of profiles configured in the users AWS cli config file."
            echo "      If an auto-rotated credential exists for that profile, use that."
            echo ""
            echo "    r | reload )"
            echo "      Load the auto-rotated creds of the most recent profile of the current shell session."
            echo ""
            echo "    a | assume )"
            echo "      Assume the given role and export the creds to the command line."
            echo ""
            echo "    p | prompt )"
            echo "      Prompted for the 3 parts of the credential and will export it to the environment variables."
            echo ""
            echo "    s | show )"
            echo "      Shows the currently loaded profile."
            echo ""
            echo "    S | swap )"
            echo "      Change the currently loaded config & credentials set."
            echo ""
            echo "    o | open )"
            echo "      Open the AWS Console using the current environment credentials."
            echo ""
            echo "    c | clear )"
            echo "      Delete all saved profiles and unset the environment variables."
            echo ""

    esac
}
