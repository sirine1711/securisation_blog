#!/bin/bash

# Démarrer les services
service mysql start
service cron start

# Activer SSL et configurer les certificats
bash /enable-ssl.sh

# Démarrer Apache en premier plan
apache2ctl -D FOREGROUND