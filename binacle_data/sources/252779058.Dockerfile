FROM buzzy/build-debian:wheezy  
  
RUN sudo apt-get install -y curl \  
&& curl -O http://public.redjack.com/debian:wheezy/buzzy_0.5.1_amd64.deb \  
&& sudo dpkg -i buzzy_*.deb \  
&& sudo apt-get install -y -f \  
&& sudo apt-get clean \  
&& rm buzzy_*.deb \  
&& mkdir -p /home/buzzy/.cache/buzzy  

