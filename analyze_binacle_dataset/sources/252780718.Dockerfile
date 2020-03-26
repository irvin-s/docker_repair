FROM alpine  
  
RUN apk update \  
&& apk add \  
python2 \  
py2-yaml \  
libedit-dev \  
make \  
g++ \  
&& wget http://www.catb.org/~esr/open-adventure/advent-1.4.tar.gz \  
&& tar -zxvf advent-1.4.tar.gz \  
&& cd advent-1.4 \  
&& make \  
&& apk del python2 py2-yaml make g++ \  
&& rm -rf /var/cache/apk/*  
  
CMD ["/advent-1.4/advent"]

