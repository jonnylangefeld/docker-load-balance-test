FROM alpine:3.4

RUN apk add --no-cache bash syslog-ng

RUN mkdir /sidecar
COPY config/* /etc/syslog-ng/
COPY docker-entrypoint.sh /docker-entrypoint.sh
VOLUME ["/sidecar"]
CMD ["syslog-ng", "-F"]
ENTRYPOINT ["/docker-entrypoint.sh"]
