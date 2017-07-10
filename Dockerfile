#################################################################
#
#                    ##        .
#              ## ## ##       ==
#           ## ## ## ##      ===
#       /""""""""""""""""\___/ ===
#  ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~
#       \______ o          __/
#         \    \        __/
#          \____\______/
#
#################################################################

FROM ubuntu:latest

RUN apt-get update
RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:adiscon/v8-stable 
RUN apt-get update
RUN apt-get -y --no-install-recommends install rsyslog  && rm -rf /var/cache/apk/*
# RUN apk add --update rsyslog rsyslog-tls && rm -rf /var/cache/apk/*
RUN apt-get -y --no-install-recommends install nodejs-legacy
RUN apt-get -y --no-install-recommends install npm
RUN npm -g install json
ADD run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh
ADD rsyslog.conf /etc/
ADD loggly.crt /etc/rsyslog.d/keys/ca.d/
    
EXPOSE 514
EXPOSE 514/udp

CMD ["/tmp/run.sh"]

