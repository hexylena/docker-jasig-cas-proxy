FROM debian:stable-slim
MAINTAINER Eric Rasche <hxr@hx42.org>

ENV DOCKERIZE_VERSION v0.4.0
RUN DEBIAN_FRONTEND=noninteractive \
	apt-get -qq update && \
	apt-get install -y apache2 libapache2-mod-auth-cas wget && \
	a2enmod auth_cas proxy_http headers ssl && \
	wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
	&& tar -C /usr/local/bin -xzvf dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
	&& rm dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz

ADD startup.sh /bin/startup.sh
ADD default.tmpl /etc/apache2/sites-enabled/000-default.tmpl
ADD ssl.tmpl /etc/apache2/sites-enabled/001-ssl.tmpl
ADD auth_cas.conf /etc/apache2/mods-enabled/auth_cas.conf.tmpl

ENV LISTEN_PORT=80 \
	LISTEN_PORT_SSL=443 \
	BACKEND_PORT=8000 \
	BACKEND_NAME=target \
	SERVER_NAME=example.com \
	DOMAIN=example.edu \
	CAS_LOGIN_URL=https://erasche.github.io/fakeCAS/autoLogin.html \
	CAS_VALIDATE_URL=https://erasche.github.io/fakeCAS/serviceValidate.html

CMD dockerize \
	-template /etc/apache2/sites-enabled/000-default.tmpl:/etc/apache2/sites-enabled/000-default.conf \
	-template /etc/apache2/sites-enabled/001-ssl.tmpl:/etc/apache2/sites-enabled/001-ssl.conf \
	-template /etc/apache2/mods-enabled/auth_cas.conf.tmpl:/etc/apache2/mods-enabled/auth_cas.conf.add \
	/bin/startup.sh
