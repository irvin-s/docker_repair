FROM alpine:3.1  
# Update  
RUN apk update  
RUN apk add --update python python-dev py-pip icu-dev gcc g++  
  
# Install app dependencies  
RUN pip install polyglot  
RUN polyglot download embeddings2.en  
RUN polyglot download ner2.en  

