FROM alpine:latest

MAINTAINER resyst-it <florian.cauzardjarry@gmail.com>

RUN apk --update add bind && rm -rf /var/cache/apk/*

COPY files/named.conf /etc/bind/named.conf

EXPOSE 953/tcp 53/tcp 53/udp

CMD ["/docker-entrypoint.sh"]
