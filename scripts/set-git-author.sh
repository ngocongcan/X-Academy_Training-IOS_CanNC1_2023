set -e

scriptDir=`dirname "$BASH_SOURCE"`

USER_NAME="Can Ngo"
read -p "Enter commit user.name[Can Ngo]: " USER_NAME
USER_EMAIL="ngocongcan@gmail.com"
read -p "Enter commit user.email[ngocongcan@gmail.com]: " USER_EMAIL

printf "Setup git author for $rootDir\n"
git config user.name $USER_NAME
git config user.email $USER_EMAIL
