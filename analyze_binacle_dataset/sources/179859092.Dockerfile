FROM tomcat:8
MAINTAINER Justin Littman <justinlittman@gwu.edu>

ENV LC_ALL C.UTF-8
RUN apt-get update && apt-get install -y \
        python \
        python-pip
#Install prop_util to allow updating runtime.properties
RUN mkdir /usr/local/vivo-install
ADD prop_util /usr/local/vivo-install
RUN pip install -r /usr/local/vivo-install/requirements.txt
#Install appdeps to allow checking for application dependencies
WORKDIR /usr/local/vivo-install
RUN wget -L https://github.com/gwu-libraries/appdeps/raw/master/appdeps.py
WORKDIR $CATALINA_HOME/bin
CMD python /usr/local/vivo-install/appdeps.py --wait-secs 60 --file-wait /usr/local/vivo/home/runtime.properties --port-wait db:3306 \
    && python /usr/local/vivo-install/prop_util.py /usr/local/vivo/home/runtime.properties $MYDOMAIN \
    && ./catalina.sh run
