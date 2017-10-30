#!/bin/sh

# clear
clear

echo "Enable Networking"
ifconfig eth0 up

echo "Update Packages"
apt update

echo "Install Packages"
apt install -y python-pip python-setuptools unzip vim wget

echo "Clean Packages"
apt clean all

# install & upgrade python packages
pip install --upgrade pip 

echo "Update DB"
updatedb

echo "Download and Extract Web2py"
mkdir /home/site/
rm -rf /home/site/web2py
cd /home/site/
rm -f web2py_src.zip
wget -c http://web2py.com/examples/static/web2py_src.zip
unzip -o web2py_src.zip

echo "Remove Examples app"
rm -rf /home/site/web2py/applications/examples

echo "Make Directory"
mkdir /home/site/web2py/applications/welcome/cache

# create ssl cert
cd /home/site/web2py
openssl genrsa 1024 > web2py.key && chmod 400 web2py.key
openssl req -new -x509 -nodes -sha1 -days 1780 -key web2py.key > web2py.crt
openssl x509 -noout -fingerprint -text < web2py.crt > web2py.info

#echo "Edit welcome layout"
#vim /home/site/web2py/applications/welcome/views/layout.html

echo 'Done'
