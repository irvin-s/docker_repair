FROM ceecko/app  
COPY scripts /tmp/scripts  
  
# these two commands need to be split, otherwise  
# it results in "Text file is busy" error  
RUN chmod u+x /tmp/scripts/install-puppeteer.sh  
RUN /tmp/scripts/install-puppeteer.sh \  
&& rm -rf /tmp/scripts

