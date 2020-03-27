FROM php:7.3-alpine

ARG SSH_DIR="/etc/ssh"
ARG SSH_CONFIG="/etc/ssh/config"

USER root

RUN apk --update --no-cache add sshpass openssh-client bash git
RUN set -xe \
    && mkdir -p $SSH_DIR \
	&& echo -e "Host *\n\tStrictHostKeyChecking=no\n\n" >> $SSH_CONFIG
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer 
