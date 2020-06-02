FROM projectcypress/cypress:release-v3.2.2  
  
RUN mkdir -p /home/app/cypress/temp && \  
mkdir -p /home/app/cypress/data && \  
mkdir -p /home/app/cypress/public/data && \  
mkdir -p /home/app/cypress/public/data/upload  
  
RUN chown -R app:app /home/app/cypress/temp && \  
chown -R app:app /home/app/cypress/data && \  
chown -R app:app /home/app/cypress/public/data && \  
chown -R app:app /home/app/cypress/tmp/ && \  
chown -R app:app /home/app/cypress/public/data/upload  

