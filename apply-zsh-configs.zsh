#!/bin/bash

apply_zsh_configs() {
    echo
    echo "> Checking if the .zsh-configs directory exists in the user's directory..."
    ZSH_CONFIGS_EXISTS=$(exec ls -a $HOME | grep -x .zsh-configs)
    # echo "ZSH_CONFIGS_EXISTS = \"$ZSH_CONFIGS_EXISTS\""\

    # Check if the .zsh-configs directory exists
    if [[ -z $ZSH_CONFIGS_EXISTS ]]
    then
        echo "> .zsh-configs directory doesn't exist"
        echo

        read -p "> Please confirm if you want to create a new .zsh-configs directory (Y/n): " ZSH_CONFIGS_CONSENT

        # Changing the input to uppercase
        ZSH_CONFIGS_CONSENT=$(echo $ZSH_CONFIGS_CONSENT | tr "[:lower:]" "[:upper:]")

        if [[ $ZSH_CONFIGS_CONSENT == "Y" ]]
        then
            echo
            echo "> Creating a new .zsh-configs directory..."
            
            mkdir -p $HOME/.zsh-configs
            
            echo
            echo "> Done!"
        else
            echo
            echo "> No changes to be done, exiting."
            exit
        fi
    fi

    # Validating again if the .zsh-configs directory exists
    ZSH_CONFIGS_EXISTS=$(exec ls -a $HOME | grep -x .zsh-configs)

    if [[ $ZSH_CONFIGS_EXISTS == ".zsh-configs" ]]
    then
        echo
        echo "> .zsh-configs directory found!"

        echo
        echo "> Backing up the existing contents to \"$HOME/.zsh-configs/\" folder..."

        BACKUP_FOLDER_NAME="backup_$(date +'%F_%H-%M-%S')"
        mkdir -p $HOME/.zsh-configs/$BACKUP_FOLDER_NAME

        cp -r $HOME/.zsh-configs/ $HOME/.zsh-configs/$BACKUP_FOLDER_NAME/

        echo
        echo "> Backed up the existing contents to \"$HOME/.zsh-configs/$BACKUP_FOLDER_NAME\" folder"

        echo
        echo "> Applying the configs from \"$CURRENT_DIR/zsh/.zsh-configs\" to the \"$HOME/.zsh-configs\" directory..."
        cp -r $CURRENT_DIR/zsh/.zsh-configs/ $HOME/.zsh-configs/

        echo
        echo "> Done!"

    else
        echo
        echo "> .zsh-configs doesn't exist, exiting"
        exit
    fi
}


# A bash script that copies the ZSH custom config files from "zsh" directory inside the repo to the user's directory
echo 
echo "----------------------------------------"
echo "-------- apply-zsh-configs.sh ----------"
echo "----------------------------------------"

echo 
echo "> Starting"

CURRENT_DIR=$(exec pwd)

echo
read -p "Please confirm if you want to apply the configurations to your user's .zsh-configs directory (Y/n): " BACKUP_CONSENT

# Changing the input to uppercase
BACKUP_CONSENT=$(echo $BACKUP_CONSENT | tr "[:lower:]" "[:upper:]")

if [[ $BACKUP_CONSENT == "Y" ]]
then
    apply_zsh_configs
else
    echo
    echo "> No changes to be done, exiting."
fi
