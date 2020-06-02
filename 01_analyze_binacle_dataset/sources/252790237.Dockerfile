FROM ruby:2-slim  
  
RUN apt-get update && apt-get install --yes build-essential  
  
# Support UTF-8  
ENV LC_ALL=C.UTF-8  
  
# Help NokoGiri install faster  
ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=true  
  
CMD [ "bash" ]  
  

