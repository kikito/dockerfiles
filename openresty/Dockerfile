FROM        ubuntu:12.10
MAINTAINER  kikito@gmail.com

# Get latest version of all tools
RUN apt-get -y update
RUN apt-get -y upgrade

# Install Openresty
ENV OPENRESTY_VERSION 1.5.8.1
RUN apt-get -y install curl make
RUN apt-get -y install libreadline-dev libncurses5-dev libpcre3-dev libssl-dev perl
RUN curl http://openresty.org/download/ngx_openresty-$OPENRESTY_VERSION.tar.gz > /usr/src/ngx_openresty-$OPENRESTY_VERSION.tar.gz
RUN cd /usr/src && tar xzf ngx_openresty-$OPENRESTY_VERSION.tar.gz
RUN cd /usr/src/ngx_openresty-$OPENRESTY_VERSION;\
    ./configure --with-gzip;\
    make;\
    make install

# Run Nginx in the foreground
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# nginx site conf
ADD ./nginx-site.conf /etc/nginx/sites-available/default

# Install Luarocks
ENV LUAROCKS_VERSION 2.0.13
RUN curl http://luarocks.org/releases/luarocks-$LUAROCKS_VERSION.tar.gz > /usr/src/luarocks-$LUAROCKS_VERSION.tar.gz
RUN cd /usr/src && tar xzvf luarocks-$LUAROCKS_VERSION.tar.gz
RUN cd /usr/src/luarocks-$LUAROCKS_VERSION ;\
    ./configure --prefix=/usr/local/openresty/luajit \
        --with-lua=/usr/local/openresty/luajit/ \
        --lua-suffix=jit-2.1.0-alpha \
        --with-lua-include=/usr/local/openresty/luajit/include/luajit-2.1 ;\
    make ;\
    make install

# Add supervisor to manage nginx
RUN apt-get -y install supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Open HTTP and SSL ports
EXPOSE 80 443

CMD ["/usr/bin/supervisord"]
