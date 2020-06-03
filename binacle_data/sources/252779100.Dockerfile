FROM ubuntu  
  
RUN apt-get update && \  
apt-get install -y git && \  
git clone https://github.com/BWITS/misspell_fixer.git && \  
apt-get remove -y git && \  
apt -y autoremove && \  
rm -rf /var/lib/apt/lists/*  
  
WORKDIR /app  
  
ENTRYPOINT ["/misspell_fixer/misspell_fixer.sh"]  
CMD ["-h"]  

