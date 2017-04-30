FROM haproxy:1.7

COPY ./certbot /certbot

RUN apt-get update \
    && apt-get install -y cron

COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY fullchain.pem /etc/letsencrypt/live/docker-test.energy-smart.de/fullchain.pem

CMD ["/bin/sh", "/startup.sh"]
