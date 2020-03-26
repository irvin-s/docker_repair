FROM centos:7  
RUN yum install php -y  
RUN touch /imAlreadyHereBeforeYouStartTheContainer.txt  
RUN echo "some text" >> /imAlreadyHereBeforeYouStartTheContainer.txt  
COPY test.php /test.php

