FROM crystallang/crystal:0.24.1  
ADD . /src  
WORKDIR /src  
RUN crystal deps  
RUN crystal build src/kemal_youtube_retriever.cr --release -o build  
  
EXPOSE 80  
ENV KEMAL_ENV production  
ENV GA 123  
CMD ["/src/build", "-p 80"]  
  

