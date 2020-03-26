FROM java  
  
RUN useradd -u 1001 -g 0 default && \  
mkdir /moquette  
  
ADD distribution-0.9-SNAPSHOT-bundle-tar /moquette  
  
RUN chown -R 1001:0 /moquette && \  
chmod -R g+rw /moquette  
  
WORKDIR moquette  
  
  
USER 1001  
  
CMD [ "/moquette/bin/moquette.sh" ]  

