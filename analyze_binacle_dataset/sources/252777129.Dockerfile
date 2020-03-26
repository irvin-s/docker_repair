FROM scratch  
ADD config.json ./  
ADD provider/*.yaml ./  
ADD fleet ./  
CMD ["./fleet"]  

