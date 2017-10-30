#!/bin/sh

echo "Enable Networking"
ifconfig eth0 up

echo "Remove Packages"
apt remove -y at-spi banshee banshee-extension-soundmenu bluez bluez-alsa bluez-cups bluez-gstreamer evolution-data-server gnome-bluetooth libatspi1.0-0 pulseaudio-module-bluetooth unity unity-asset-pool unity-common unity-greeter unity-lens-files xchat xchat-common
apt autoremove -y

echo "Add Repository"
apt-add-repository ppa:jd-team/jdownloader
sh -c 'echo "\n# opera software repository \ndeb http://deb.opera.com/opera/ stable non-free\n" >> /etc/apt/sources.list'
sh -c 'echo "# google chrome software repository \ndeb http://dl.google.com/linux/chrome/deb/ stable main\n" >> /etc/apt/sources.list'
wget -qO - http://deb.opera.com/archive.key | apt-key add -

echo "Update Packages"
apt update

echo "Install Packages"
apt install -y acpi alacarte alsa-base alsa-utils aptitude arj bleachbit brasero bum celestia-gnome celestia chromium-browser cups-pdf desmume evince exfalso ffmpeg firefox flashplugin-installer fslint gcc gconf-editor gnome-disk-utility gnome-power-manager gnome-screensaver gnome-utils google-chrome-stable googleearth-package gstreamer0.10-plugins-bad gstreamer0.10-ffmpeg gstreamer0.10-plugins-ugly gthumb gtkorphan gwaei gwenview ibus ibus-anthy ibus-hangul ipython istanbul jdownloader k9copy kde-l10n-engb kde-l10n-ja kde-l10n-ko kipi-plugins language-pack-gnome-ja language-pack-gnome-ko language-pack-ja language-pack-ja-base language-pack-kde-en language-pack-kde-ja language-pack-kde-ko language-pack-ko language-pack-ko-base libnotify-bin libpam-smbpass libqt4-sql-sqlite linux-sound-base man-db meld mercurial mlocate mozilla-plugin-vlc nautilus nautilus-open-terminal nautilus-share numlockx openoffice.org-help-ja openoffice.org-help-ko openoffice.org-l10n-ja openoffice.org-l10n-ko openssh-server openuniverse opera p7zip p7zip-full pidgin pidgin-extprefs pidgin-facebookchat pidgin-guifications pidgin-lastfm pidgin-libnotify pidgin-microblog pidgin-musictracker pidgin-plugin-pack pidgin-skype pyrenamer python-cheetah python-dev python-dns python-epydoc python-execnet python-gconf python-genshi python-GeoIP python-glade2 python-gnome2 python-gobject python-gtk2 python-httplib2 python-jinja2 python-jsonpickle python-kid python-memcache python-openid python-psycopg2 python-rdflib python-recaptcha python-redis python-rtfcomp python-sphinx python-tk python-twitter python-wxtools python-yaml rar ratproxy rdesktop rhythmbox rsync samba shutter skype software-center songbird sphinxbase-utils stellarium subversion synaptic testdisk thunderbird thunderbird-locale-en-gb thunderbird-locale-en-us thunderbird-locale-ja thunderbird-locale-ko tomboy totem transmission tuxguitar tuxguitar-jsa txt2tags unetbootin unrar unzip vim vlc vinagre visualboyadvance-gtk wget winff zip

echo "Upgrade Packages"
apt upgrade -y

echo "Clean Packages \n"
apt clean all

echo "Virtual Machine"
mkdir /virtual\ machine
chmod 777 -R /virtual\ machine/

echo "Configure Bash History"
sed -i 's/HISTSIZE=1000/HISTSIZE=100000/g' ~/.bashrc
sed -i 's/HISTFILESIZE=2000/HISTFILESIZE=100000/g' ~/.bashrc
echo "export HISTTIMEFORMAT='%d/%m/%y %T '" >> ~/.bashrc
echo "export HISTFILE=~/.bash_history" >> ~/.bashrc

echo "Flush File System Buffers Crontab"
echo "* * * * * sync; echo 3 > /proc/sys/vm/drop_caches" > /root/crontab
crontab -u root /root/crontab

echo "Update DB"
updatedb

echo "Reboot"
reboot
