FROM haproxy:1.7

COPY ./certbot /certbot

RUN apt-get update \
    && apt-get install -y cron \

RUN /certbot/certbot-auto certonly --standalone --agree-tos -m ${EMAIL} -n -d ${EXTERNAL_URL} \
    && echo '@monthly root /certbot/certbot-auto certonly --quiet --standalone --renew-by-default -d ${EXTERNAL_URL} >> /var/log/certbot/certbot-auto-update.log' | tee --append /etc/crontab

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
