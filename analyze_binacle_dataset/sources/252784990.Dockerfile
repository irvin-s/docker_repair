FROM jekyll/jekyll:3.2.1  
  
# Install NTPD for time synchronization and timezone data.  
RUN apk --no-cache update && \  
apk --no-cache upgrade && \  
apk --no-cache add tzdata openntpd  

