apt-get update
apt-get install libcurl4-openssl-dev libssl-dev zlib1g-dev libpcap-dev -y
cd /opt
git clone https://github.com/ZerBea/hcxdumptool.git
cd hcxdumptool
make
make install
cd ..
git clone https://github.com/ZerBea/hcxtools.git
cd hcxtools
make
make install
