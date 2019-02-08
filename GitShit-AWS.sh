#Collection of awesome shit to grab on an initial kali rollout on AWS

#update
#apt get update && apt-get dist-upgrade -y
#apt autoremove -y && apt clean

#Disable Lockscreen & Screen Blanking
gsettings set org.gnome.desktop.lockdown disable-lock-screen 'true' && gsettings set org.gnome.desktop.session idle-delay 0

# Turn off Dash to Dock Intelligent Autohide
dconf write /org/gnome/shell/extensions/dash-to-dock/dock-fixed true

# Add support for 32bit stuff
dpkg --add-architecture i386

#--- Extract rockyou wordlist
gzip -dc < /usr/share/wordlists/rockyou.txt.gz > /usr/share/wordlists/rockyou.txt

cd /opt
git clone https://github.com/0x00-0x00/ShellPop
git clone https://github.com/danielmiessler/SecLists.git
git clone https://github.com/xillwillx/skiptracer.git
git clone https://github.com/DominicBreuker/pspy.git
git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git
git clone https://github.com/mthbernardes/rsg.git
git clone https://github.com/hausec/ADAPE-Script.git
git clone https://github.com/byt3bl33d3r/SILENTTRINITY.git
git clone https://github.com/lesnuages/hershell.git
git clone https://github.com/derv82/wifite2.git
git clone https://github.com/trustedsec/unicorn.git
git clone https://github.com/oddcod3/Phantom-Evasion.git
#internal Priv escalation
git clone https://github.com/pentestmonkey/unix-privesc-check.git
git clone https://github.com/pentestmonkey/windows-privesc-check.git
git clone https://github.com/411Hall/JAWS.git
git clone https://github.com/InteliSecureLabs/Linux_Exploit_Suggester.git
git clone https://github.com/rebootuser/LinEnum.git

# compress for easy moving - extract with tar -zxvf upc2.tar.gz
tar -C /opt/unix-privesc-check -czf /opt/unix-privesc-check/upc2.tar.gz unix-privesc-check2 

#mimikatz
mimikatz=$(curl -sL https://github.com/gentilkiwi/mimikatz/releases/latest | grep -i /mimikatz_trunk.zip| sed -n 's/.*href="\([^"]*\).*/\1/p')&& wget -T 5 https://github.com$mimikatz &&  unzip -o mimikatz_trunk.zip -d /opt/mimikatz && unset mimikatz && rm mimikatz_trunk.zip


#Optional Installs

#sublime
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
apt install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt update
apt install sublime-text
