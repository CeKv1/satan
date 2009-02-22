#!/bin/bash -x

/etc/init.d/apache2 start
/etc/init.d/mysql start
/usr/share/satan/scripts/phpmyadmin.sh
su -l etu `iceweasel --display=:0.0 http://localhost/phpmyadmin/`
