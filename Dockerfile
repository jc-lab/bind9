FROM alpine:latest

MAINTAINER Joseph Lee <development@jc-lab.net>

RUN apk --update add bind && rm -rf /var/cache/apk/*

COPY files/named.conf /etc/bind/named.conf
COPY entrypoint.sh /

EXPOSE 953/tcp 53/tcp 53/udp

CMD ["/entrypoint.sh"]
