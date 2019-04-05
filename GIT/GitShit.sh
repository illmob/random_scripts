#!/bin/bash
#Collection of awesome shit to grab on an initial kali rollout
# skip prompts in apt-upgrade, etc.
export DEBIAN_FRONTEND=noninteractive

printf '\n============================================================\n'
printf '[+] update Kali\n'
printf '============================================================\n\n' 
apt get update && apt-get dist-upgrade -y
apt autoremove -y && apt clean

printf '\n============================================================\n'
printf '[+] Change Password\n'
printf '============================================================\n\n 
echo -e "sup3rS3cr3tpassw0rd!\nsup3rS3cr3tpassw0rd!"|passwd root;history -d $(history 1)

printf '\n============================================================\n'
printf '[+] Change Default SSH Keys\n'
printf '============================================================\n\n' 
mkdir /etc/ssh/backup-keys
mv /etc/ssh/ssh_host_* /etc/ssh/backup-keys
dpkg-reconfigure openssh-server

printf '\n============================================================\n'
printf '[+] Disable Lockscreen & Screen Blanking & Sleep on AC\n'
printf '============================================================\n\n' 
gsettings set org.gnome.desktop.lockdown disable-lock-screen 'true'
gsettings set org.gnome.desktop.session idle-delay 0
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'

printf '\n============================================================\n'
printf '[+] Turn off Dash to Dock Intelligent Autohide\n'
printf '============================================================\n\n' 
dconf write /org/gnome/shell/extensions/dash-to-dock/dock-fixed true

printf '\n============================================================\n'
printf '[+] Add support for 32bit stuff\n'
printf '============================================================\n\n'
dpkg --add-architecture i386

printf '\n============================================================\n'
printf '[+] git cloning all the good shit\n'
printf '============================================================\n\n'
cd /opt
git clone https://github.com/danielmiessler/SecLists.git
git clone https://github.com/xillwillx/skiptracer.git && cd skiptracer && pip install -r requirements.txt && cd ..
git clone https://github.com/DominicBreuker/pspy.git
git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git


git clone https://github.com/trustedsec/unicorn.git
git clone https://github.com/oddcod3/Phantom-Evasion.git

#shells
git clone https://github.com/byt3bl33d3r/SILENTTRINITY.git
git clone https://github.com/EmpireProject/Empire.git && cd Empire &&  ./setup/install.sh && cd ..
git clone https://github.com/lesnuages/hershell.git
git clone https://github.com/mthbernardes/rsg.git
git clone https://github.com/0x00-0x00/ShellPop.git && apt install python-argcomplete && cd ShellPop && pip install -r requirements.txt && python setup.py install && cd ..
git clone https://github.com/antonioCoco/SharPyShell.git && cd SharPyShell && pip install -r requirements.txt && cd ..


#internal Priv escalation
git clone https://github.com/pentestmonkey/unix-privesc-check.git
git clone https://github.com/pentestmonkey/windows-privesc-check.git
git clone https://github.com/411Hall/JAWS.git
git clone https://github.com/InteliSecureLabs/Linux_Exploit_Suggester.git
git clone https://github.com/rebootuser/LinEnum.git
git clone https://github.com/PowerShellMafia/PowerSploit.git
git clone https://github.com/hausec/ADAPE-Script.git
git clone https://github.com/dirkjanm/ldapdomaindump.git && pip install ldap3 dnspython && cd ldapdomaindump && python setup.py install && cd ..
git clone https://github.com/CroweCybersecurity/ad-ldap-enum.git && pip install python-ldap

#Passive Pcap Tools - https://www.netresec.com/?page=PcapFiles
git clone https://github.com/lgandx/PCredz.git
git clone https://github.com/k0fin/pktrecon.git && cd pktrecon && pip install -r requirements.txt && cd ..
git clone https://github.com/DanMcInerney/net-creds.git

#Network Scanning
git clone https://github.com/marco-lancini/goscan.git && cd goscan && chmod +x goscan && mv ./goscan /usr/local/bin/goscan && cd ..

pip install shodan
mkdir ~/scripts && cd ~/scripts
wget https://raw.githubusercontent.com/superkojiman/onetwopunch/master/onetwopunch.sh
wget https://github.com/d0nkeys/redteam/raw/master/scanners/nmap/scan.sh
wget https://github.com/d0nkeys/redteam/raw/master/scanners/nmap/scan.parallel.sh

mkdir ~/powershell && cd ~/powershell
wget https://raw.githubusercontent.com/peewpw/Invoke-WCMDump/master/Invoke-WCMDump.ps1
wget https://github.com/d0nkeys/redteam/raw/master/privilege-escalation/JuicyPotato.ps1
wget https://github.com/d0nkeys/redteam/raw/master/privilege-escalation/JuicyPotato32.ps1
wget https://github.com/d0nkeys/redteam/raw/master/lateral-movement/Run-As.ps1

printf '\n============================================================\n'
printf '[+] compressing privesc - extract with: tar -zxvf upc2.tar.gz\n'
printf '============================================================\n\n'
tar -C /opt/unix-privesc-check -czf /opt/unix-privesc-check/upc2.tar.gz unix-privesc-check2

printf '\n============================================================\n'
printf '[+] Extract rockyou wordlist\n'
printf '============================================================\n\n' 
gzip -dc < /usr/share/wordlists/rockyou.txt.gz > /usr/share/wordlists/rockyou.txt

#mimikatz
mimikatz=$(curl -sL https://github.com/gentilkiwi/mimikatz/releases/latest | grep -i /mimikatz_trunk.zip| sed -n 's/.*href="\([^"]*\).*/\1/p')&& wget -T 5 https://github.com$mimikatz &&  unzip -o mimikatz_trunk.zip -d /opt/mimikatz && unset mimikatz && rm mimikatz_trunk.zip

printf '\n============================================================\n'
printf '[+] Installing Alfa Drivers,golang +env, gnome-screenshot\n'
printf '[+] pip + env, patator, zmap, chromium, crackmapexec\n'
printf '============================================================\n\n'
apt-get -y install \
    realtek-rtl88xxau-dkms \
    golang \
    gnome-screenshot \
    terminator \
    python-pip \
    python3-dev \
    python3-pip \
    patator \
    zmap \
    chromium \
    crackmapexec

python2 -m pip install pipenv
python3 -m pip install pipenv
mkdir -p /root/go
gopath_exp='export GOPATH="$HOME/.go"'
path_exp='export PATH="/usr/local/go/bin:$GOPATH/bin:$PATH"'
sed -i '/export GOPATH=.*/c\' ~/.profile
sed -i '/export PATH=.*GOPATH.*/c\' ~/.profile
echo $gopath_exp | tee -a "$HOME/.profile"
grep -q -F "$path_exp" "$HOME/.profile" || echo $path_exp | tee -a "$HOME/.profile"
. "$HOME/.profile"
sed -i 's#Exec=/usr/bin/chromium %U#Exec=/usr/bin/chromium --no-sandbox %U#g' /usr/share/applications/chromium.desktop


printf '\n============================================================\n'
printf '[+] Installing Bloodhound\n'
printf '============================================================\n\n'
mkdir -p /usr/share/neo4j/logs /usr/share/neo4j/run
grep '^root   soft    nofile' /etc/security/limits.conf || echo 'root   soft    nofile  40000
root   hard    nofile  60000' >> /etc/security/limits.conf
grep 'NEO4J_ULIMIT_NOFILE=60000' /etc/default/neo4j 2>/dev/null || echo 'NEO4J_ULIMIT_NOFILE=60000' >> /etc/default/neo4j
apt-get install -y bloodhound
neo4j start

printf '\n============================================================\n'
printf '[+] Initializing Metasploit Database\n'
printf '============================================================\n\n'
systemctl start postgresql
systemctl enable postgresql
msfdb init

printf '\n============================================================\n'
printf '[+] Installing Sublime Text\n'
printf '============================================================\n\n
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | apt-key add -
apt install apt-transport-https
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
apt update
apt install sublime-text

printf '\n============================================================\n'
printf '[+] Finalize.\n'
printf '============================================================\n\n
updatedb
rmdir ~/Music ~/Public ~/Videos ~/Templates &>/dev/null


#Optional Installs

#Powershell
#apt update && apt -y install curl gnupg apt-transport-https
#curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
#echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-debian-stretch-prod stretch main" > /etc/apt/sources.list.d/powershell.list
#apt update
#apt -y install powershell #running pwsh will start up PowerShell, then run: Update-Help
