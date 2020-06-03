FROM node:8.1  
LABEL maintainer "Bradley Weston <brad@legalweb.org.uk>"  
RUN npm set progress=false && \  
npm install -g --progress=false \  
eslint@^4.1 \  
eslint-config-airbnb@^15.0 \  
eslint-config-airbnb-base@^11.2 \  
eslint-plugin-import@^2.8 \  
eslint-plugin-jsx-a11y@^6.0 \  
eslint-plugin-react@^7.1 \  
eslint-plugin-html@3.2.2  
WORKDIR /app  
ENTRYPOINT ["eslint"]  

