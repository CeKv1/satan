#!/bin/bash

/etc/init.d/apache2 start
/etc/init.d/slapd start
su -l etu `iceweasel --display=:0.0 http://localhost/phpldapadmin/`
