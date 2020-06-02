FROM andyrbell/mountebank:1.14.1  
EXPOSE 4546 5555  
ADD imposters /mb  
  
CMD ["mb", "--configfile", "/mb/imposters.ejs", "--allowInjection"]  

