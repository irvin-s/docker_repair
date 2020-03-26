FROM python:2.7  
WORKDIR /usr/src/app  
  
RUN apt-get update && apt-get install -y \  
crf++ \  
ruby  
  
RUN git clone https://github.com/NYTimes/ingredient-phrase-tagger.git .  
  
ADD CRF++-0.58.tar.gz .  
  
RUN cd CRF++-0.58 \  
&& ./configure --prefix /usr/lib \  
&& make \  
&& make install \  
&& ./configure \  
&& make \  
&& make install\  
&& cd ..  
  
RUN python setup.py install \  
&& ./roundtrip.sh  
  
COPY parse.sh /usr/local/bin/  
  
CMD ["parse.sh"]  

