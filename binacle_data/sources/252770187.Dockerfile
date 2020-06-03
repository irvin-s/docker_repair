FROM python  
  
RUN pip install droopescan  
WORKDIR /wd  
ENTRYPOINT ["droopescan"]  

