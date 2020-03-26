FROM fpco/stack-build:lts-5.16  
ENV APP /tmp/servant-base  
ADD . ${APP}  
WORKDIR ${APP}  
RUN stack install --only-dependencies  

