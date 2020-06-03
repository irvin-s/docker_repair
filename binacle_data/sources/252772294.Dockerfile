FROM avatao/exploitation:ubuntu-14.04  
  
RUN apt-get -qy update \  
&& apt-get -qy install \  
byacc \  
libpcre++-dev \  
libtool \  
pcregrep \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY . /  
  
RUN cd /opt/distorm \  
&& python setup.py install \  
&& python setup.py clean --all \  
\  
&& cd /opt/volatility \  
&& python setup.py install \  
&& python setup.py clean --all \  
\  
&& cd /opt/yara \  
&& autoreconf --force --install \  
&& ./configure --prefix=/usr \  
&& make \  
&& make install \  
&& make clean \  
\  
&& pip install pycrypto ujson \  
&& chown -R user: /home/user /opt  

