#!/bin/bash
#Collection of awesome shit to grab on an initial kali rollout
printf '\n============================================================\n'
printf '[+] Fx root colors\n'
printf '============================================================\n\n' 
echo "PS1='\[\033[1;31m\]\u@\h\[\033[1;34m\]\w:\[\033[0;37m\]\\$'" >> \root\.bashrc
source ~/.bashrc

printf '\n============================================================\n'
printf '[+] update Kali\n'
printf '============================================================\n\n' 
apt get update && apt-get dist-upgrade -y
apt autoremove -y && apt clean

printf '\n============================================================\n'
printf '[+] Change Default SSH Keys\n'
printf '============================================================\n\n' 
mkdir /etc/ssh/backup-keys
mv /etc/ssh/ssh_host_* /etc/ssh/backup-keys
dpkg-reconfigure openssh-server

printf '\n============================================================\n'
printf '[+] Add support for 32bit stuff\n'
printf '============================================================\n\n'
dpkg --add-architecture i386

printf '\n============================================================\n'
printf '[+] git cloning all the good shit\n'
printf '============================================================\n\n'
cd /opt

printf '\n============================================================\n'
printf '[+] Install Initial Recon Tools\n'
printf '============================================================\n\n'
pip install shodan
git clone https://github.com/xillwillx/skiptracer.git && cd skiptracer && pip install -r requirements.txt && cd ..
git clone https://github.com/pry0cc/Doh365.git

printf '\n============================================================\n'
printf '[+] Install Wordlists\n'
printf '============================================================\n\n'
git clone https://github.com/danielmiessler/SecLists.git
gzip -dc < /usr/share/wordlists/rockyou.txt.gz > /usr/share/wordlists/rockyou.txt

printf '\n============================================================\n'
printf '[+] Install Foothold Tools\n'
printf '============================================================\n\n'
git clone https://github.com/trustedsec/unicorn.git
git clone https://github.com/oddcod3/Phantom-Evasion.git
git clone https://github.com/swisskyrepo/PayloadsAllTheThings.git
git clone https://github.com/danielbohannon/Invoke-Obfuscation.git
git clone https://github.com/phackt/stager.dll.git
git clone https://github.com/infosecn1nja/MaliciousMacroMSBuild.git
git clone https://github.com/GreatSCT/GreatSCT.git

printf '\n============================================================\n'
printf '[+] Install Network Discovery Tools\n'
printf '============================================================\n\n'
git clone https://github.com/lgandx/PCredz.git
git clone https://github.com/k0fin/pktrecon.git && cd pktrecon && pip install -r requirements.txt && cd ..
git clone https://github.com/DanMcInerney/net-creds.git
git clone https://github.com/ropnop/windapsearch.git
pip install python-ldap #or apt-get install python-ldap
git clone https://github.com/dirkjanm/adidnsdump && cd adidnsdump && pip install . && cd ..
pip install bloodhound

printf '\n============================================================\n'
printf '[+] Install Local Situational Awareness Tools\n'
printf '============================================================\n\n'
git clone https://github.com/DominicBreuker/pspy.git
git clone https://github.com/diego-treitos/linux-smart-enumeration.git

printf '\n============================================================\n'
printf '[+] Install Priv Escalation Tools\n'
printf '============================================================\n\n'
git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git
git clone https://github.com/pentestmonkey/unix-privesc-check.git
git clone https://github.com/pentestmonkey/windows-privesc-check.git
git clone https://github.com/411Hall/JAWS.git
git clone https://github.com/InteliSecureLabs/Linux_Exploit_Suggester.git
git clone https://github.com/rebootuser/LinEnum.git
wget https://github.com/rasta-mouse/Watson/archive/2.0.zip && unzip 2.0.zip && rm 2.0.zip

printf '\n============================================================\n'
printf '[+] Install Credential Tools\n'
printf '============================================================\n\n'
#mimikatz
mimikatz=$(curl -sL https://github.com/gentilkiwi/mimikatz/releases/latest | grep -i /mimikatz_trunk.zip| sed -n 's/.*href="\([^"]*\).*/\1/p')&& wget -T 5 https://github.com$mimikatz &&  unzip -o mimikatz_trunk.zip -d /opt/mimikatz && unset mimikatz && rm mimikatz_trunk.zip
git clone https://github.com/Hackndo/lsassy.git && cd lsassy && python3 setup.py install && cd /opt
git clone https://github.com/skelsec/pypykatz.git && cd pypykatz && python3 setup.py install && cd /opt
git clone https://github.com/TarlogicSecurity/kerbrute && cd kerbrute && pip install -r requirements.txt && cd /opt
git clone https://github.com/0x09AL/RdpThief.git
git clone https://github.com/r3motecontrol/Ghostpack-CompiledBinaries.git
git clone https://github.com/Mr-Un1k0d3r/MiniDump.git
git clone https://github.com/outflanknl/Dumpert.git
git clone https://github.com/xFreed0m/RDPassSpray.git
git clone https://github.com/realoriginal/ppdump-public.git
git clone https://github.com/hoangprod/AndrewSpecial.git

printf '\n============================================================\n'
printf '[+] Install Extra Scripts\n'
printf '============================================================\n\n'
mkdir ~/scripts && cd ~/scripts
wget https://raw.githubusercontent.com/superkojiman/onetwopunch/master/onetwopunch.sh
wget https://github.com/d0nkeys/redteam/raw/master/scanners/nmap/scan.sh
wget https://github.com/d0nkeys/redteam/raw/master/scanners/nmap/scan.parallel.sh
mkdir ~/powershell && cd ~/powershell
wget https://raw.githubusercontent.com/peewpw/Invoke-WCMDump/master/Invoke-WCMDump.ps1
wget https://github.com/d0nkeys/redteam/raw/master/privilege-escalation/JuicyPotato.ps1
wget https://github.com/d0nkeys/redteam/raw/master/privilege-escalation/JuicyPotato32.ps1
wget https://github.com/d0nkeys/redteam/raw/master/lateral-movement/Run-As.ps1
wget https://raw.githubusercontent.com/itm4n/PrivescCheck/master/Invoke-PrivescCheck.ps1
wget https://github.com/Mr-Un1k0d3r/PoisonHandler/raw/master/Execute-PoisonHandler.ps1
wget https://raw.githubusercontent.com/dafthack/DomainPasswordSpray/master/DomainPasswordSpray.ps1
mkdir ~/csharp && cd ~/csharp
wget https://github.com/cobbr/SharpSploit/archive/v1.5.zip && unzip v1.5.zip && rm v1.5.zip

printf '\n============================================================\n'
printf '[+] Install Lateral Movement Tools\n'
printf '============================================================\n\n'
gem install evil-winrm
cd /opt
git clone https://github.com/Mr-Un1k0d3r/SCShell.git

printf '\n============================================================\n'
printf '[+] Install Wireless Tools\n'
printf '============================================================\n\n'
cd /opt
# Deploy hcxtools
apt-get update
apt-get install libcurl4-openssl-dev libssl-dev zlib1g-dev libpcap-dev -y
cd /opt
git clone https://github.com/ZerBea/hcxdumptool.git && cd hcxdumptool && make && make install && cd ..
git clone https://github.com/ZerBea/hcxtools.git && cd hcxtools && make && make install && cd ..
apt-get install jq
git clone https://github.com/staz0t/hashcatch
git clone git clone https://github.com/InfamousSYN/rogue.git && cd ./rogue && python install.py ..

printf '\n============================================================\n'
printf '[+] Initializing Metasploit Database\n'
printf '============================================================\n\n'
systemctl start postgresql
systemctl enable postgresql
msfdb init

printf '\n============================================================\n'
printf '[+] Finalize.\n'
printf '============================================================\n\n'
updatedb
rmdir ~/Music ~/Public ~/Videos ~/Templates &>/dev/null
