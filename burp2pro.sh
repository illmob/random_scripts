#!/bin/bash
# Useful for installing Burp Pro jar on kali and changing the sidemenu shortcuts from community to pro where its installed to
# illmob newb scripts ftw
echo ""
echo " ██╗██╗     ██╗     ███╗   ███╗ ██████╗ ██████╗ "
echo " ██║██║     ██║     ████╗ ████║██╔═══██╗██╔══██╗"
echo " ██║██║     ██║     ██╔████╔██║██║   ██║██████╔╝"
echo " ██║██║     ██║     ██║╚██╔╝██║██║   ██║██╔══██╗"
echo " ██║███████╗███████╗██║ ╚═╝ ██║╚██████╔╝██████╔╝"
echo " ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚═════╝"
echo "           -=[Burp Pro installer]=-"
echo ""
echo "Where do you want to install Burp Pro?"

filepath=
while read -ep $'(i.e. /opt/ or /usr/share/)\nPath: ' filepath; do
    if [ -d $filepath ]; then 
      echo "$filepath already exists..."
      break
    elif [ ! -d $filepath ]; then
      echo "$filepath is being created..."
      mkdir -p $filepath
      printf -v filepath "${filepath[@]%/}" #remove slash
      echo $filepath
      break
    fi
done

burppath=
while read -ep $'Where is your BurpPro.Jar?(use tab-complete)\nPath: ' burppath; do
    if [ ! -f $burppath ]; then
      echo ".jar not found!"
      break
    else 
      echo "Moving .jar to new directory."
      mv $burppath $filepath/burpsuite_pro.jar 
      break
    fi
done

echo "Create new shortcuts for kali side menu by editing the file config file"
sed -i 's/Exec\=sh \-c \"java \-jar \/usr\/bin\/burpsuite\"/Exec\=sh \-c \"java \-jar \$filepath\/burpsuite_pro\.jar\"/g' /usr/share/applications/kali-burpsuite.desktop
sed -i 's/Exec\=sh \-c \"java \-jar \/usr\/bin\/burpsuite\"/Exec\=sh \-c \"java \-jar \$filepath\/burpsuite_pro\.jar\"/g' /usr/share/kali-menu/applications/kali-burpsuite.desktop

echo -e "Complete!\nClick on burp suite icon in sidebar and enter your license key!"
