FROM scratch  
  
COPY . /  
  
EXPOSE 41017  
CMD [ "/idea-ls" ]  
  

