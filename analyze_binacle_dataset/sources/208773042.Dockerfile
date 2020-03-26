FROM ruby:2.3.1-alpine
MAINTAINER b00stfr3ak
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1

RUN apk add --update build-base libffi-dev sqlite-dev postgresql-dev  \
    ruby-dev libpcap-dev git nmap libpcap-dev libxslt libxml2-dev libxslt-dev \
    ncurses ncurses-dev readline-dev \
    && rm -rf /var/cache/apk/*

RUN cd /root/ && git clone https://github.com/rapid7/metasploit-framework.git \
    && cd metasploit-framework && bundle install

CMD ["sh"]
# CMD ["/root/metasploit-framework/./msfconsole"]
