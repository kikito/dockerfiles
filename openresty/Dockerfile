FROM        ubuntu:12.10
MAINTAINER  kikito@gmail.com

# Make sure that apt-get does not try to show interactive config dialogs
ENV DEBIAN_FRONTEND noninteractive

# Allow restarting of services updated by apt-get
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d && chmod a+x /usr/sbin/policy-rc.d

# use english and UTF8 please
RUN locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales

# Get latest version of all tools
RUN apt-get -y update && apt-get -y upgrade

# Install Openresty
ENV OPENRESTY_VERSION 1.5.8.1
RUN apt-get -y install curl libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make \
 && cd /usr/src \
 && curl http://openresty.org/download/ngx_openresty-$OPENRESTY_VERSION.tar.gz > ngx_openresty-$OPENRESTY_VERSION.tar.gz \
 && tar xzf ngx_openresty-$OPENRESTY_VERSION.tar.gz \
 && cd /usr/src/ngx_openresty-$OPENRESTY_VERSION \
 && ./configure \
      --with-luajit \
      --sbin-path=/usr/sbin/nginx \
      --conf-path=/etc/nginx/nginx.conf \
      --error-log-path=/var/log/nginx/error.log \
      --pid-path=/var/run/nginx.pid \
      --lock-path=/var/lock/nginx.lock \
      --http-log-path=/var/log/nginx/access.log \
      --http-client-body-temp-path=/var/lib/nginx/body \
      --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
      --http-proxy-temp-path=/var/lib/nginx/proxy \
      --http-scgi-temp-path=/var/lib/nginx/scgi \
      --http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
      --with-http_gunzip_module \
      --with-mail \
      --with-mail_ssl_module \
      --with-ipv6 \
      --with-sha1=/usr/include/openssl \
      --with-md5=/usr/include/openssl \
      --with-http_gzip_static_module \
      --with-http_sub_module \
  && make \
  && make install

# Create temp files folders for nginx
RUN mkdir -p /var/lib/nginx/body \
 && mkdir -p /var/lib/nginx/fastcgi \
 && mkdir -p /var/lib/nginx/proxy \
 && mkdir -p /var/lib/nginx/scgi \
 && mkdir -p /var/lib/nginx/uwsgi

# Add supervisor to manage nginx
RUN apt-get -y install supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Attach volumes
VOLUME /usr/share/nginx/www
VOLUME /var/log/nginx

# Allow HTTP traffic
EXPOSE 80

# nginx site conf
RUN rm -f /etc/nginx/nginx.conf
ADD ./nginx.conf /etc/nginx/nginx.conf

CMD ["/usr/bin/supervisord"]
