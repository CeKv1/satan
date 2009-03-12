#!/bin/bash -x

/etc/init.d/apache2 start
/etc/init.d/mysql start
su -l etu `iceweasel --display=:0.0 http://localhost/phpmyadmin/`
