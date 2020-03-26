FROM node:6-slim  
  
LABEL maintainer "Charlie McClung <charlie.mcclung@autodesk.com>"  
  
RUN npm install --global cmr1-ts3-bot-verify-gw2  
  
ENTRYPOINT [ "ts3-bot-verify-gw2" ]

