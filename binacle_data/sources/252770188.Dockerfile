FROM asannou/go-cve-dictionary:2015  
RUN go-cve-dictionary fetchnvd -last2y  

