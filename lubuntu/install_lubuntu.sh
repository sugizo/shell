#!/bin/sh

echo "Enable Networking"
ifconfig eth0 up

echo "Customize Login Screen"
sed -i 's/# numlock=0/numlock=1/g' /etc/xdg/lubuntu/lxdm/lxdm.conf
sed -i 's/lang=1/lang=0/g' /etc/xdg/lubuntu/lxdm/lxdm.conf

echo "Configure Bash History"
sed -i 's/HISTSIZE=1000/HISTSIZE=100000/g' ~/.bashrc
sed -i 's/HISTFILESIZE=2000/HISTFILESIZE=100000/g' ~/.bashrc
echo "export HISTTIMEFORMAT='%d/%m/%y %T '" >> ~/.bashrc
echo "export HISTFILE=~/.bash_history" >> ~/.bashrc

echo "Make Crontab"
echo "* * * * * /bin/sync; /bin/echo 3 > /proc/sys/vm/drop_caches" > /root/crontab
#echo "* * * * * /bin/rm -f ~/.local/share/rhythmbox/rhythmdb.xml" >> /root/crontab
#echo "* 1 * * * /usr/bin/scp -Crv /media/sugizo/My\ Book/Cloud/* /host/Cloud/" >> /root/crontab
#echo "* 2 * * * /usr/bin/rsync -avuz /var/cache/apt/archives/* /host/linux/ubuntu/12.10/desktop/" >> /root/crontab
crontab -u root /root/crontab

echo "Add Google DNS"
sed -i 's/#prepend domain-name-servers 127.0.0.1;/prepend domain-name-servers 8.8.8.8 8.8.4.4;/g' /etc/dhcp/dhclient.conf
echo "dns-nameservers 8.8.8.8 8.8.4.4" >> /etc/network/interfaces

echo "Add Repository"
#apt-add-repository ppa:jd-team/jdownloader
#add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
#echo "deb http://deb.opera.com/opera/ stable non-free" > /etc/apt/sources.list.d/opera.list
#echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
#echo "deb http://apt.spideroak.com/ubuntu-spideroak-hardy/ release restricted" > /etc/apt/sources.list.d/spideroak.com.sources.list
#echo "deb http://repo.wuala.com stable main" > /etc/apt/sources.list.d/wuala.list
#wget -qO - http://deb.opera.com/archive.key | apt-key add -
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -

echo "Update Packages"
apt update

echo "Install Packages"
apt install -y --force-yes apache2 chromium-browser firefox flashplugin-installer gedit gedit-plugins gnome-system-monitor graphviz indicator-multiload mysql-server mysql-client nautilus nautilus-open-terminal nautilus-share pavucontrol php5 php5-mysql pulseaudio python-pgpme python-pygraphviz python-setuptools python-tk unzip vagrant vim vlc wget
#apt install -y --force-yes acpi alacarte alsa-base alsa-utils aptitude arj bleachbit brasero bum celestia-gnome celestia chromium-browser cups-pdf evince exfalso ffmpeg firefox flashplugin-installer fslint gcc gconf-editor gedit gedit-plugins git gjiten gnome-disk-utility gnome-power-manager gnome-screensaver googleearth-package gstreamer0.10-ffmpeg gstreamer0.10-fluendo-mp3 gstreamer1.0-plugins-bad gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gthumb gtkorphan guayadeque gwenview hplip ibus ibus-anthy ibus-hangul indicator-multiload ipython istanbul kanjipad kde-l10n-engb kde-l10n-ja kde-l10n-ko kipi-plugins landscape-client landscape-client-ui landscape-common language-pack-gnome-ja language-pack-gnome-ko language-pack-ja language-pack-ja-base language-pack-kde-en language-pack-kde-ja language-pack-kde-ko language-pack-ko language-pack-ko-base libnotify-bin libpam-smbpass libqt4-sql-sqlite libreoffice-help-ja libreoffice-help-ko libreoffice-l10n-ja libreoffice-l10n-ko linux-headers-generic linux-sound-base man-db meld mercurial mlocate mtp-tools mtpfs nautilus nautilus-open-terminal nautilus-share numlockx nvidia-current-updates openssh-server openuniverse p7zip p7zip-full pavucontrol pcsxr pidgin pidgin-extprefs pidgin-guifications pidgin-lastfm pidgin-libnotify pidgin-microblog pidgin-musictracker pidgin-plugin-pack pyrenamer python-cheetah python-dev python-dns python-epydoc python-execnet python-gconf python-genshi python-GeoIP python-git python-glade2 python-gnome2 python-gobject python-gtk2 python-httplib2 python-jinja2 python-jsonpickle python-kid python-memcache python-openid python-psycopg2 python-rdflib python-recaptcha python-redis python-rtfcomp python-sphinx python-tk python-twitter python-wxtools python-yaml rar ratproxy rdesktop rhythmbox rsync samba shotwell shutter software-center sphinxbase-utils stellarium subversion synaptic testdisk thunderbird thunderbird-locale-en-gb thunderbird-locale-en-us thunderbird-locale-ja thunderbird-locale-ko tomboy tor totem transmission tuxguitar tuxguitar-jsa txt2tags unetbootin unrar unzip vim vlc vinagre wget winff zip

echo "Remove Packages"
apt purge -y evolution-data-server python-ubuntuone-client python-ubuntuone-control-panel python-ubuntuone-storageprotocol rhythmbox-ubuntuone ubuntuone-client unity unity-asset-pool unity-common unity-lens-application unity-lens-files unity-lens-music unity-lens-photos unity-lens-shopping unity-lens-video unity-scope-gdocs unity-scope-video-remote unity-services
apt autoremove -y

echo "Upgrade Packages"
apt upgrade -y

echo "Backup Packages \n"
#rsync -avuz /var/cache/apt/archives/* /host/linux/ubuntu/12.10/desktop/

echo "Clean Packages"
apt clean all

echo "Enable Override GPU Validation for Adobe Flash Player"
mkdir /etc/adobe/
echo OverrideGPUValidation=true >> /etc/adobe/mms.cfg

echo "Update DB"
updatedb

echo "Reboot"
reboot
