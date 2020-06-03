FROM mono:4.8  
MAINTAINER CodinGame <coders@codingame.com>  
COPY entrypoint.sh /  
COPY build.sh /project/build  
ENTRYPOINT ["/entrypoint.sh"]  

