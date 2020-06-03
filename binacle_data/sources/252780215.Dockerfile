FROM fotengauer/altlinux-sisyphus  
  
RUN apt-get -qq update \  
&& apt-get -qq install hasher su \  
&& apt-get -qq clean \  
&& rm -rf /var/lib/apt/lists/* \  
&& mkdir /var/lib/apt/lists/partial \  
&& useradd user \  
&& hasher-useradd user \  
&& su -l -c "mkdir ~/hasher" user  
  
CMD ["/bin/su", "-", "user"]  

