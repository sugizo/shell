#!/bin/sh

source ~/site/bin/activate

python ~/site/web2py/web2py.py --nogui --no-banner -a 'a' -i 0.0.0.0 -p 8000

# https
#sudo python ~/site/web2py/web2py.py --nogui --no-banner -a 'a' -c web2py.crt -k web2py.key --interfaces=0.0.0.0:443:web2py.key:web2py.crt;0.0.0.0:80 -p 443
