FROM ubuntu:16.10
MAINTAINER ADEOSecurity Team <security@adeo.com.tr>

# Install all requirement library
RUN DEBIAN_FRONTEND=noninteractive && \
  apt-get update --fix-missing && \
  apt-get -qq -y install git libnet-dns-perl python python-pip libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev liblzma-dev

# Create gemrc file
RUN echo "gem: --no-ri --no-rdoc" > /etc/gemrc

# Install bundler
RUN gem install bundle

WORKDIR /opt

# Install fierce
RUN git clone https://github.com/AysenurKaraslan/fierce-domain-scanner.git /opt/fierce
WORKDIR /opt/fierce
RUN rm -rf /usr/local/bin/fierce
RUN ln -s /opt/fierce/fierce.pl /usr/local/bin/fierce
RUN ln -s /opt/fierce/hosts.txt /usr/local/bin/hosts.txt
RUN chmod +x /usr/local/bin/fierce
RUN chmod +x /usr/local/bin/hosts.txt

WORKDIR /opt

# Install joomlavs
RUN git clone https://github.com/AysenurKaraslan/Sedef-Joomlavs.git /opt/joomlavs
WORKDIR /opt/joomlavs
RUN bundle install --without test
RUN rm -rf /usr/local/bin/joomlavs
RUN ln -s /opt/joomlavs/joomlavs.rb /usr/local/bin/joomlavs
RUN chmod +x /usr/local/bin/joomlavs

WORKDIR /opt

# Install theHarvester
RUN git clone https://github.com/laramies/theHarvester.git /opt/theharvester
WORKDIR /opt/theharvester
RUN pip install requests
RUN rm -rf /usr/local/bin/theharvester
RUN ln -s /opt/theharvester/theHarvester.py /usr/local/bin/theharvester
RUN chmod +x /usr/local/bin/theharvester

WORKDIR /opt

# Install wpscan
RUN git clone https://github.com/wpscanteam/wpscan.git /opt/wpscan
WORKDIR /opt/wpscan
RUN bundle install --without test
RUN /opt/wpscan/wpscan.rb --update --verbose
RUN rm -rf /usr/local/bin/wpscan
RUN ln -s /opt/wpscan/wpscan.rb /usr/local/bin/wpscan
RUN chmod +x /usr/local/bin/wpscan
RUN gem install yajl

WORKDIR /opt

# Sync work path and project
RUN mkdir /opt/subdomainfinder
ADD . /opt/subdomainfinder
WORKDIR /opt/subdomainfinder
RUN bundle install --without test
RUN ln -s /opt/subdomainfinder/SubdomainFinder.rb /usr/local/bin/sedef
RUN chmod +x /usr/local/bin/sedef
RUN chmod 777 /opt/subdomainfinder/reports

CMD ["/bin/bash"]
