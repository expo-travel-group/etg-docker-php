# Versions 3.8 and 3.7 are current stable supported versions.
FROM alpine:3.9

# trust this project public key to trust the packages.
ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

## you may join the multiple run lines here to make it a single layer

# make sure you can use HTTPS
RUN apk --update --no-cache add ca-certificates

# add the repository, make sure you replace the correct versions if you want.
RUN echo "https://dl.bintray.com/php-alpine/v3.9/php-7.3" >> /etc/apk/repositories

# install php and some extensions
RUN apk add --update --no-cache php
RUN apk add --update --no-cache php-zip
RUN apk add --update --no-cache php-bcmath
RUN apk add --update --no-cache php-gd
RUN apk add --update --no-cache php-memcached
RUN apk add --update --no-cache php-mysqli
RUN apk add --update --no-cache php-xsl
RUN apk add --update --no-cache php-ldap
RUN apk add --update --no-cache php-curl
RUN apk add --update --no-cache php-mbstring
RUN apk add --update --no-cache php-json
RUN apk add --update --no-cache php-phar

RUN ln -s /usr/bin/php7 /usr/local/bin/php

# SSH
ARG SSH_DIR="/etc/ssh"
ARG SSH_CONFIG="/etc/ssh/config"

USER root

RUN apk --update --no-cache add curl sshpass openssh-client bash git
RUN set -xe \
    && mkdir -p $SSH_DIR \
	&& echo -e "Host *\n\tStrictHostKeyChecking=no\n\n" >> $SSH_CONFIG
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer 
