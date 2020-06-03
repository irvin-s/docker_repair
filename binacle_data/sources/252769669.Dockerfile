FROM arimakouyou/ubuntu-japanese:14.04  
  
RUN sudo add-apt-repository -y universe \  
&& sudo add-apt-repository -y ppa:groonga/ppa \  
&& sudo apt-get update \  
&& sudo apt-get install -y libgroonga-dev ruby-dev zlib1g-dev \  
&& sudo apt-get clean \  
&& sudo rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*  
  
RUN sudo gem install milkode --no-ri --no-rdoc \  
&& milk init --default  
  
EXPOSE 9292  
ADD cmd.sh /cmd.sh  
RUN chmod +x /cmd.sh  
ENTRYPOINT ["/cmd.sh"]  

