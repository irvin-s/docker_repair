FROM node:8  
  
# Use yarn to get npm v5(!) - https://stackoverflow.com/a/44280995/2803757  
RUN yarn global add npm@5  

