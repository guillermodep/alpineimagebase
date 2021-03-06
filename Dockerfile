FROM alpine:3.9

ENV S6VERSION=v1.22.1.0

# Install packages
RUN set -ex \
 && apk --no-cache add \
      nginx \
      tcpdump \
      rsync \
      wireshark \
      nmap \
      iftop \ 
      vnstat \ 
      bash \
      curl \
      git \
      php-fpm \
 && curl -sSfL "https://github.com/just-containers/s6-overlay/releases/download/${S6VERSION}/s6-overlay-amd64.tar.gz" | tar -xzv -C / \
 && rm -Rf /var/www/*

# Copy configuration files to root
COPY rootfs /

# Fix permissions
RUN chown -Rf nginx:www-data /var/www/

WORKDIR /var/www
EXPOSE 80 443

ENTRYPOINT ["/init"]
