FROM haproxy:1.7

COPY ./certbot /certbot

RUN apt-get update \
    && apt-get install -y cron

RUN /certbot/certbot-auto -n -h --os-packages-only

COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

#COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY haproxy.pem /localcert

CMD ["/bin/sh", "/startup.sh"]
