#!/bin/bash

backup_zsh_configs() {
    echo
    echo "> Checking if the .zsh-configs directory exists in the user's directory..."
    ZSH_CONFIGS_EXISTS=$(exec ls -a $HOME | grep -x .zsh-configs)
    echo "ZSH_CONFIGS_EXISTS = \"$ZSH_CONFIGS_EXISTS\""

    if [[ $ZSH_CONFIGS_EXISTS == ".zsh-configs" ]]
    then
        echo "> .zsh-configs directory exists"
        echo 
        read -p "Please confirm if you want to backup the contents under the .zsh-configs directory (Y/n): " BACKUP_CONSENT

        # Changing the input to uppercase
        BACKUP_CONSENT=$(echo $BACKUP_CONSENT | tr "[:lower:]" "[:upper:]")
        # echo "BACKUP_CONSENT = \"$BACKUP_CONSENT\""

        if [[ $BACKUP_CONSENT == "Y" ]]
        then
            echo "> Copying the \"$HOME/.zsh-configs\" directory to \"$CURRENT_DIR/zsh/.zsh-configs\" folder..."

            ZSH_CONFIGS_EXISTS_REPO=$(exec ls -a $CURRENT_DIR/zsh | grep .zsh-configs)
            echo ZSH_CONFIGS_EXISTS_REPO="$ZSH_CONFIGS_EXISTS_REPO"

            if [[ -z $ZSH_CONFIGS_EXISTS_REPO ]]
            then
                echo "Folder doesn't exist, creating a folder..."
                mkdir -p $CURRENT_DIR/zsh/.zsh-configs
            fi

            cp $HOME/.zsh-configs/* $CURRENT_DIR/zsh/.zsh-configs/
            echo "> Done!"
        else
            echo "> Skipping this step"
        fi

    else
        echo "> .zsh-configs doesn't exist, exiting"
        exit
    fi
}

# A bash script that copies the ZSH related files from the user's directory to the "zsh" directory inside this repo
echo 
echo "----------------------------------------"
echo "------------- zsh-backup.sh ------------"
echo "----------------------------------------"

echo 
echo "> Starting"

CURRENT_DIR=$(exec pwd)

echo 
echo "current directory: \"$CURRENT_DIR\""
echo "user's directory: \"$HOME\""

echo 
echo "> Checking if a .zshrc file exists in the user's directory..."
ZSHRC_EXISTS=$(exec ls -a $HOME | grep -x .zshrc)
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
diff $HOME/.zshrc $CURRENT_DIR/zsh/.zshrc

echo 
read -p "Please confirm if you want to backup the user's .zshrc file (Y/n): " BACKUP_CONSENT

# Changing the input to uppercase
BACKUP_CONSENT=$(echo $BACKUP_CONSENT | tr "[:lower:]" "[:upper:]")
# echo "BACKUP_CONSENT = \"$BACKUP_CONSENT\""

if [[ $BACKUP_CONSENT == "Y" ]]
then
    echo "> Copying the \"$HOME/.zshrc\" file to \"$CURRENT_DIR/zsh/.zshrc\" file..."
    cp $HOME/.zshrc $CURRENT_DIR/zsh/
    echo "> Done!"
else
    echo "> Skipping this step"
fi

backup_zsh_configs

