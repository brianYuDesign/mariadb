FROM alpine:3.9

LABEL maintainer="Tass"

RUN apk add --no-cache  \
	mysql \
	mysql-client \
	mariadb-server-utils \
	supervisor && \
	addgroup mysql mysql && \
	mkdir /scripts && \
	rm -rf /var/cache/apk/*

COPY ./docker/startup.sh /scripts/startup.sh
COPY ./docker/supervisord.conf /etc/supervisor.d/supervisord.ini

RUN chmod +x /scripts/startup.sh

# VOLUME ["/var/lib/mysql"]
EXPOSE 3306

CMD /usr/bin/supervisord -n -c /etc/supervisord.conf;