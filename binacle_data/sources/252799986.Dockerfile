FROM alpine:latest  
  
RUN apk add --no-cache \  
bash \  
nodejs  
  
ENV STYLELINT_VERSION 7.8.0  
ENV STYLELINT_ORDER_VERSION 0.2.2  
ENV STYLELINT_SCSS_VERSION 1.4.1  
ENV ESLINT_VERSION 3.18.0  
RUN npm install -g stylelint@${STYLELINT_VERSION} \  
stylelint-scss@${STYLELINT_SCSS_VERSION} \  
stylelint-order@${STYLELINT_ORDER_VERSION} \  
eslint@${ESLINT_VERSION}  
  
WORKDIR /app  
  
ENTRYPOINT ["bash"]  

