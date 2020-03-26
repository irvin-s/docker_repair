FROM python:3.5
MAINTAINER John Readey <jreadey@hdfgroup.org>
RUN pip install --upgrade pip                           ; \
    pip install numpy                                   ; \
    pip install aiobotocore                             ; \
    pip install pytz                                    ; \
    pip install requests                                ; \
    pip install psutil  
