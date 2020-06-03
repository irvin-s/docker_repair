FROM node:0.10  
RUN npm install -g drakov  
  
EXPOSE 3000  
ENTRYPOINT ["drakov", "-f", "/*.md", "-p", "3000"]

