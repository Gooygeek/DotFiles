
# First clear the screen (no default message or login prompt)
clear
# Login welcome message
echo -e "\e[38;5;82m$(figlet -ct KGOL.XYZ)\e[00m"

# Make sure all the other settings are still loaded properly
if [ -f ~/.bash_custom ]; then
    . ~/.bashrc
fi
