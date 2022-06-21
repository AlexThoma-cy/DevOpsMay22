echo "
███████╗███████╗ ██████╗██████╗ ███████╗████████╗     ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ████████╗ ██████╗ ██████╗
██╔════╝██╔════╝██╔════╝██╔══██╗██╔════╝╚══██╔══╝    ██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗╚══██╔══╝██╔═══██╗██╔══██╗
███████╗█████╗  ██║     ██████╔╝█████╗     ██║       ██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║   ██║   ██║   ██║██████╔╝
╚════██║██╔══╝  ██║     ██╔══██╗██╔══╝     ██║       ██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║   ██║   ██║   ██║██╔══██╗
███████║███████╗╚██████╗██║  ██║███████╗   ██║       ╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║   ██║   ╚██████╔╝██║  ██║
╚══════╝╚══════╝ ╚═════╝╚═╝  ╚═╝╚══════╝   ╚═╝        ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝
"
echo "
╔═╗┬─┐┌─┐┌─┐┌┬┐┌─┐┌┬┐  ┌┐ ┬ ┬  ╔═╗┬ ┬┌─┐┬─┐┌─┐┌┐┌  ╦  ┌─┐┬  ┬┬
║  ├┬┘├┤ ├─┤ │ ├┤  ││  ├┴┐└┬┘  ╚═╗├─┤├─┤├┬┘│ ││││  ║  ├┤ └┐┌┘│
╚═╝┴└─└─┘┴ ┴ ┴ └─┘─┴┘  └─┘ ┴   ╚═╝┴ ┴┴ ┴┴└─└─┘┘└┘  ╩═╝└─┘ └┘ ┴
"
  read -p "Press enter to start the program"

  # Checks if src dir and secretGenerator file is not exists then download the tar file else send a message.

wget https://devops-may22.s3.eu-north-1.amazonaws.com/secretGenerator.tar.gz
echo "--------------Download complete--------------" && sleep 2

 #Extract the tar.gz content to the home folder
tar -xf ~/secretGenerator.tar.gz
echo "--------------Extract complete--------------" && sleep 2

 #Creates new directory named secretDir
mkdir src/secretDir
echo "--------------Directory secretDir Created--------------" && sleep 2

# Checks if maliciousFiles dir is exists and remove it else show message.
if [ -d "src/maliciousFiles" ]; then
  echo "Deleting MaliciousFiles dir from the src dir" && sleep 2
  sudo rm -rf src/maliciousFiles
else
       echo " MaliciousFiles is already deleted " && sleep 2
fi

# Checks if .secret file in the secretDir if not create the .secret file in this dir.
if [ ! -f "src/secretDir/.secret" ]; then
        echo -e "Creating .secret file in the src/secretDir dir " && sleep 2
  sudo touch src/secretDir/.secret
fi

# Checks if the .secret file permission is not 600 and add R and W to the other users
OCTAL_PERMISSIONS=$(stat -c "%a" src/secretDir/.secret)
if [ "$OCTAL_PERMISSIONS" != "600" ]; then
  echo "changing file .secret permissions to read and write only for the other users" && sleep 2
  sudo chmod 006 src/secretDir/.secret
fi

# practice file linking understanding
if [ -L 'src/important.link' ] && [ ! -e 'src/important.link' ]; then
  echo "Remove the linking from important file" && sleep 2
  sudo unlink src/important.link
fi

sudo cat src/CONTENT_TO_HASH | xargs | md5sum > src/secretDir/.secret && echo "Done! Your secret was stored in secretDir/.secret"