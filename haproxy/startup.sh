{ \
echo "global"; \
echo "    maxconn 100"; \
echo "    log /sidecar/log local0"; \

echo "defaults"; \
echo "    log global"; \
echo "    mode http"; \
echo "    option httpclose"; \
echo "    timeout connect 5000ms"; \
echo "    timeout client 50000ms"; \
echo "    timeout server 50000ms"; \

echo "frontend http-in"; \
echo "    bind *:80"; \
} > /usr/local/etc/haproxy/haproxy.cfg
if ${GEN_CERT}; then
    /certbot/certbot-auto certonly --standalone --agree-tos -m ${EMAIL} -n -d ${EXTERNAL_URL}
    cat /etc/letsencrypt/live/${EXTERNAL_URL}/cert.pem /etc/letsencrypt/live/${EXTERNAL_URL}/privkey.pem > /etc/letsencrypt/live/${EXTERNAL_URL}/haproxy.pem
    { \
    echo "    bind *:443 ssl crt /etc/letsencrypt/live/${EXTERNAL_URL}/haproxy.pem"; \
    echo "    redirect scheme https if !{ ssl_fc }"; \
    } >> /usr/local/etc/haproxy/haproxy.cfg
else
    echo "don't create ssl certificate"
fi
{ \
echo "    acl has_web1 path_beg /web1"; \
echo "    acl has_web2 path_beg /web2"; \

echo "    use_backend web1 if has_web1"; \
echo "    use_backend web2 if has_web2"; \

echo "    default_backend web2"; \

echo "backend web1"; \
echo "    reqrep ^([^\ ]*\ /)web1[/]?(.*)     \1\2"; \
echo "    server web1 web1:80 check"; \

echo "backend web2"; \
echo "    reqrep ^([^\ ]*\ /)web2[/]?(.*)     \1\2"; \
echo "    server web2 web2:80 check"; \
} >> /usr/local/etc/haproxy/haproxy.cfg
echo "@monthly root /certbot/certbot-auto certonly --quiet --standalone --renew-by-default -d ${EXTERNAL_URL} >> /var/log/certbot/certbot-auto-update.log" | tee --append /etc/crontab
haproxy -f /usr/local/etc/haproxy/haproxy.cfg
