#  
# Node.js Dockerfile  
#  
#  
# Pull base image.  
FROM dockerfile/nodejs  
  
# append nodejs binaries TO PATH  
ENV PATH node_modules/.bin:$PATH  
  
# Expose port  
EXPOSE 8080  
# Add source  
ADD . /src  
  
# Set Working directory  
WORKDIR /src  
  
# install deps  
RUN npm install  
  
# run app  
CMD ["node", "lib/citeServer.js"]

