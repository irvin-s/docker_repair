FROM ubuntu:14.04  
MAINTAINER Cole Brokamp cole.brokamp@gmail.com  
  
RUN useradd docker \  
&& mkdir /home/docker \  
&& chown docker:docker /home/docker \  
&& addgroup docker staff  
  
RUN apt-get update && apt-get install -y \  
make \  
wget \  
nano \  
curl \  
sqlite3 \  
libsqlite3-dev \  
flex \  
ruby-full ruby-rubyforge \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN wget https://colebrokamp-dropbox.s3.amazonaws.com/geocoder.db -P /opt  
  
# need Ruby 3 for the gems  
RUN apt-get update && apt-get install -y apt-file \  
&& apt-file update \  
&& apt-get install software-properties-common -y \  
&& apt-add-repository ppa:brightbox/ruby-ng \  
&& apt-get update \  
&& apt-get install ruby2.2 ruby2.2-dev -y \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN gem install sqlite3  
  
RUN mkdir /root/geocoder  
COPY . /root/geocoder  
RUN chmod +x /root/geocoder/geocode.rb  
  
RUN cd /root/geocoder \  
&& make install \  
&& gem install Geocoder-US-2.0.4.gem  
  
ENTRYPOINT ["ruby", "/root/geocoder/geocode.rb"]  

