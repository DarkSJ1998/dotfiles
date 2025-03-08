#!/bin/bash

# A bash script that copies the ZSH related files from the user's directory to the "zsh" directory inside this repo
echo 
echo "----------------------------------------"
echo "------------- zsh-backup.sh ------------"
echo "----------------------------------------"

echo 
echo "> Starting"

CURRENT_DIR=$(exec pwd)
USER_DIR=~

echo 
echo "current directory: \"$CURRENT_DIR\""
echo "user's directory: \"$USER_DIR\""

echo 
echo "> Checking if a .zshrc file exists in the user's directory..."
ZSHRC_EXISTS=$(exec ls -a $USER_DIR | grep -x .zshrc)
# echo "ZSHRC_EXISTS = \"$ZSHRC_EXISTS\""

if [[ $ZSHRC_EXISTS == ".zshrc" ]]
then
    echo "> .zshrc file exists"
else
    echo "> .zshrc doesn't exist, exiting"
    exit
fi

echo 
echo "> Checking the differences between the user's .zshrc file and the one in this repo..."
diff $USER_DIR/.zshrc $CURRENT_DIR/zsh/.zshrc

echo 
read -p "Please confirm if you want to backup the user's .zshrc file (Y/n): " BACKUP_CONSENT

# Changing the input to uppercase
BACKUP_CONSENT=${BACKUP_CONSENT^^}
# echo "BACKUP_CONSENT = \"$BACKUP_CONSENT\""

if [[ $BACKUP_CONSENT == "Y" ]]
then
    echo "> Copying the \"$USER_DIR/.zshrc\" file to \"$CURRENT_DIR/zsh/.zshrc\" file..."
    cp $USER_DIR/.zshrc $CURRENT_DIR/zsh/
    echo "> Done!"
else
    echo "> Skipping this step"
fi
