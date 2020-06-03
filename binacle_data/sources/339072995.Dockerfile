FROM metabase/metabase

RUN apk update && apk add python3 python3-dev py-pip 

ADD requirements.txt /setup-files/

RUN pip3 install -r /setup-files/requirements.txt

ADD metabase_setup.py /setup-files/ 

ADD start.sh /

ENTRYPOINT ["/start.sh"]



