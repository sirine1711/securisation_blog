#!/bin/bash

# Script pour activer les modules Apache nécessaires pour HTTPS
# et générer un certificat auto-signé si nécessaire

# Activer les modules Apache nécessaires
a2enmod ssl
a2enmod headers
a2enmod rewrite

# Vérifier si les certificats existent déjà
if [ ! -f /etc/ssl/certs/ssl-cert-snakeoil.pem ] || [ ! -f /etc/ssl/private/ssl-cert-snakeoil.key ]; then
    # Générer un certificat SSL auto-signé
    mkdir -p /etc/ssl/vulnblog
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/ssl/private/ssl-cert-snakeoil.key \
        -out /etc/ssl/certs/ssl-cert-snakeoil.pem \
        -subj "/C=FR/ST=Paris/L=Paris/O=VulnBlog/CN=localhost"
    
    echo "Certificat SSL auto-signé généré avec succès."
else
    echo "Les certificats SSL existent déjà."
fi

# Redémarrer Apache pour appliquer les changements
service apache2 restart

echo "Configuration SSL terminée. Apache a été redémarré."
