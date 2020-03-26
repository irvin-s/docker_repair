FROM mhart/alpine-node  
  
RUN mkdir app  
ADD . app  
  
WORKDIR app  
RUN npm install  
  
ENV RIAK_NODES=riak:8087  
ENV PORT=3000  
EXPOSE 3000  
CMD ["node", "index.js"]  

