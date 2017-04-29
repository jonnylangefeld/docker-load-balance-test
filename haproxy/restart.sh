docker rm -f haproxy
docker build -t haproxy:custom .
docker run -dit -p 80:80 --name haproxy --network energysmart_default haproxy:custom
