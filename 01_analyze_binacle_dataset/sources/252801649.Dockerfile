FROM alpine  
  
ENV msg base_v2  
ENV specific proxy  
CMD echo "${msg}-${specific}"  

