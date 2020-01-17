# Assume a role/profile and export the creds to environment variables
aws-creds() {
    # awk 1 = The seperator is everything between ']' and '['. Therefore, only what is inside the square brackets are piped on.
    #    This will therefore return a list of 'profile <profile>'. (except the first line, which would be 'default').
    # awk 2 = If the line is greater than 1 (i.e. not the first line), then print the second item.
    #    This therefore prints all and only the roles that can be assumed
    PROFILES=$(awk -F"\\\]|\\\[" '/^\[/{print $2}' ~/.aws/config | awk '{if(NR>1)print $2}')

    # This provides a multiple choice method of selecting a profile.
    #    The role will then be assumed and the resulting creds will be exported to the environment varibles
    select PROFILE in $PROFILES; do
        res=`aws sts assume-role --role-arn $(aws configure get $PROFILE.role_arn) --role-session-name my_profile_session --profile $PROFILE`
        export AWS_ACCESS_KEY_ID=`echo $res | jq -r '.Credentials.AccessKeyId'`
        export AWS_SECRET_ACCESS_KEY=`echo $res | jq -r '.Credentials.SecretAccessKey'`
        export AWS_SESSION_TOKEN=`echo $res | jq -r '.Credentials.SessionToken'`
        export AWS_REGION=`aws configure get region --profile $PROFILE`
        break
    done
}

