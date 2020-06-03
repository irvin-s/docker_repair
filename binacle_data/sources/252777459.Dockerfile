# Copyright 2017 <chaishushan{AT}gmail.com>. All rights reserved.  
# Use of this source code is governed by a Apache  
# license that can be found in the LICENSE file.  
FROM frolvlad/alpine-oraclejdk8  
  
LABEL MAINTAINER="chaishushan@gmail.com"  
  
WORKDIR /root  
COPY ./ditaa0_9 /ditaa0_9  
  
ENTRYPOINT ["java", "-jar", "/ditaa0_9/ditaa0_9.jar"]  
CMD []  

