FROM lisk/testnet:0.9.12a  
RUN echo "*:*:*:*:password" > /home/lisk/.pgpass  
RUN ls -al /home/lisk/  
RUN chmod 0600 /home/lisk/.pgpass  
VOLUME /home/lisk  
CMD ["pwd"]

