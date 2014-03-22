FROM        kikito/base:0.5.1
MAINTAINER  kikito@gmail.com

# Install Openresty
ENV OPENRESTY_VERSION 1.5.8.1

RUN apt-get -y install curl libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl make \
 && cd /usr/src \
 && curl http://openresty.org/download/ngx_openresty-$OPENRESTY_VERSION.tar.gz > ngx_openresty-$OPENRESTY_VERSION.tar.gz \
 && tar xzf ngx_openresty-$OPENRESTY_VERSION.tar.gz \
 && cd /usr/src/ngx_openresty-$OPENRESTY_VERSION \
 && ./configure \
    --prefix=/opt/openresty \
    --with-luajit \
    --with-http_gunzip_module \
    --with-mail \
    --with-mail_ssl_module \
    --with-ipv6 \
    --with-http_gzip_static_module \
    --with-http_sub_module \
    --with-sha1=/usr/include/openssl \
    --with-md5=/usr/include/openssl \
    --conf-path=/etc/nginx/nginx.conf \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/lock/nginx.lock \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --http-client-body-temp-path=/var/nginx/client_body_temp \
    --http-fastcgi-temp-path=/var/nginx/fastcgi_temp \
    --http-proxy-temp-path=/var/nginx/proxy_temp \
    --http-scgi-temp-path=/var/nginx/scgi_temp \
    --http-uwsgi-temp-path=/var/nginx/uwsgi_temp \
 && make \
 && make install \
 && mkdir -p /var/nginx/client_body_temp \
 && mkdir -p /var/nginx/fastcgi_temp \
 && mkdir -p /var/nginx/proxy_temp \
 && mkdir -p /var/nginx/scgi_temp \
 && mkdir -p /var/nginx/uwsgi_temp \
 && rm -rf /root/ngx_openresty-$OPENRESTY_VERSION*

# Attach volumes
VOLUME /usr/share/nginx/www
VOLUME /var/log/nginx
VOLUME /etc/nginx/conf.d

ADD nginx.conf /etc/nginx/nginx.conf
ADD openresty.logrotate /etc/logrotate.d/openresty
ADD openresty.conf /etc/supervisor/conf.d/

# Allow HTTP traffic
EXPOSE 80
