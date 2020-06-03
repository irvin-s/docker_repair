FROM azole/testbase  
  
# pull  
RUN git clone https://github.com/azole/docker-auto-build-test.git  
WORKDIR /docker-auto-build-test  
RUN npm install  
  
# run test  
CMD ["npm", "test"]  

