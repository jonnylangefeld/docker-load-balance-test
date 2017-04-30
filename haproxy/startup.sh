echo ${EMAIL}
/certbot/certbot-auto certonly --standalone --agree-tos -m ${EMAIL} -n -d ${EXTERNAL_URL}
echo '@monthly root /certbot/certbot-auto certonly --quiet --standalone --renew-by-default -d ${EXTERNAL_URL} >> /var/log/certbot/certbot-auto-update.log' | tee --append /etc/crontab
haproxy -f /usr/local/etc/haproxy/haproxy.cfg
