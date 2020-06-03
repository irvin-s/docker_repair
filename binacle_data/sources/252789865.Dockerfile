FROM docker:17.06  
RUN apk add \--no-cache bash && /bin/ln -sf /bin/bash /bin/sh  

