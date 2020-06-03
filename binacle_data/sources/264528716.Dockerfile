# Docker container for solidfire-graphite-collector
# aaron.patten@netapp.com | @jedimt
FROM alpine
MAINTAINER aaron.patten@netapp.com
RUN apk update \
       && apk add py-pip git bash 
#RUN pip install solidfire-sdk-python==1.4.0.271
RUN pip install solidfire-sdk-python==1.5.0.87.post1
RUN pip install requests graphyte logging
ADD solidfire_graphite_collector.py /solidfire_graphite_collector.py
ADD wrapper.sh /wrapper.sh
ENTRYPOINT /wrapper.sh

