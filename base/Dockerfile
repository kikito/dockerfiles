FROM        debian:jessie
MAINTAINER  kikito@gmail.com

# Make sure that apt-get does not try to show interactive config dialogs
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update && apt-get -y upgrade

RUN apt-get -y install supervisor cron logrotate

ADD supervisor /etc/supervisor

# Execute supervisor on build
ONBUILD CMD supervisord -n
