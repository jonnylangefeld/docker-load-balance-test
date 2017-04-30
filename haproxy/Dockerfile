FROM haproxy:1.7

COPY ./certbot /certbot

RUN apt-get update \
    && apt-get install -y cron

RUN /certbot/certbot-auto -n

COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

#COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
#COPY haproxy.pem /etc/letsencrypt/live/docker-test.energy-smart.de/haproxy.pem

CMD ["/bin/sh", "/startup.sh"]
