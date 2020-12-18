#!/bin/bash
#####################################################
# Passively collects subdomains without bruteforcing
# using returned data in SSL/TLS certificates
# Usage: certs.sh [domain.name]
#####################################################

banner() {
    echo -e "\e[33m"
    echo -e "     ▄▄· ▄▄▄ .▄▄▄  ▄▄▄▄▄.▄▄ · "
    echo -e "    ▐█ ▌▪▀▄.▀·▀▄ █·•██  ▐█ ▀."
    echo -e "    ██ ▄▄▐▀▀▪▄▐▀▀▄  ▐█.▪▄▀▀▀█▄"
    echo -e "    ▐███▌▐█▄▄▌▐█•█▌ ▐█▌·▐█▄▪▐█"
    echo -e "    ·▀▀▀  ▀▀▀ .▀  ▀ ▀▀▀  ▀▀▀▀ \e[0m"
    echo -e "\e[92m-=[Passive Sub-Domain Enumeration]=-\n\e[0m"
}
banner  # show the banner

# check if a domain name was entered
if [ -z "$*" ]; then echo -e "[\033[31mx\e[0m]\033[31m ERROR:\e[0m Need a domain name" >&2;echo -e "└──\e[93mUsage:\e[0m certs.sh [domain.name]\n";exit 1;fi

# check to see if jq is installed
if ! [ -x "$(command -v jq)" ]; then echo -e "[\033[31mx\e[0m]\033[31m ERROR:\e[0m jq is not installed. sudo apt install jq" >&2; exit 1;fi

#strip the slashes and other shit from the domain input
url=`echo -n $1 | sed -e 's/[^/]*\/\/\([^@]*@\)\?\([^:/]*\).*/\2/'`

echo -e "├──── [\e[92m*\e[0m] GATHERING SUBDOMAINS FROM:"
#oneliners to strip out the returned data
echo -e "│      └── [\e[92m+\e[0m] \e[37mcrt.sh\e[0m"
enum_crtsh(){ curl -s "https://crt.sh/?q=%25.$url" | sed 's/<\/\?[^>]\+>/\n/g' | sort -u | grep -v "LIKE" | grep -v "crt.sh" | grep $url | sed 's/ //' | grep -v "*" | grep $url;}
crtsh=`enum_crtsh $url`
echo -e "│      └── [\e[92m+\e[0m] \e[37mcertspotter.com\e[0m"
enum_certspotter(){ curl -s "https://certspotter.com/api/v0/certs?domain=$url"  | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | uniq | grep $url;}
certspotter=`enum_certspotter $url`
echo -e "│      └── [\e[92m+\e[0m] \e[37mhackertarget.com\e[0m"
enum_hackertarget(){ curl -s "https://api.hackertarget.com/hostsearch/?q=$url" | cut -d',' -f1 | sort -u;}
hackertarget=`enum_hackertarget $url`
echo -e "│      └── [\e[92m+\e[0m] \e[37malienvault.com\e[0m"
enum_alienvault(){ curl -s "https://otx.alienvault.com/api/v1/indicators/domain/$url/passive_dns" | grep -o -E "[a-zA-Z0-9._-]+\.$url";}
alienvault=`enum_alienvault $url`

# sort and unique and lowercase the results and spit it out to a file
echo -e $crtsh $certspotter $hackertarget $alienvault | tr -s " " "\n" | tr '[:upper:]' '[:lower:]' |sort -u -o subdomains.txt
echo -e "└── [\e[92m+\e[0m] Complete. Results in \e[93msubdomains.txt\e[0m"
echo -e "└── [\e[92m*\e[0m] Found \e[93m$(wc -l<subdomains.txt)\e[0m subdomains.\n"
