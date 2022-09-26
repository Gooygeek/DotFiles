
source ~/.config/zsh/plugins/ssh-find-agent.sh

# Start the agent on login
if [ -z "$SSH_AUTH_SOCK" ] ; then
    ssh_find_agent -a || eval $(ssh-agent) > /dev/null
fi
