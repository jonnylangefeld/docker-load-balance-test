FROM haproxy:1.7
RUN apt-get update \
    && apt-get install -y cron \
    && /certbot/certbot-auto certonly --standalone --agree-tos -m $EMAIL -n -d $EXTERNAL_URL \
    && echo '@monthly root /certbot/certbot-auto certonly --quiet --standalone --renew-by-default -d $EXTERNAL_URL >> /var/log/certbot/certbot-auto-update.log' | tee --append /etc/crontab

COPY ./certbot /certbot
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
