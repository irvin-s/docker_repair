FROM brimstone/ubuntu:14.04  
LABEL FUNCTION_NAME "youtube-dl"  
  
RUN package python  
  
ADD https://yt-dl.org/latest/youtube-dl /usr/local/bin/youtube-dl  
  
RUN chmod 755 /usr/local/bin/youtube-dl  
  
ENTRYPOINT ["/usr/local/bin/youtube-dl"]  

