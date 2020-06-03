FROM fedora:25
RUN dnf install -y git python-pip gcc python-devel postgresql-devel redhat-rpm-config

RUN mkdir -p /opt/app
WORKDIR /opt/app

RUN git clone https://github.com/jacobian/channels-example && \
    cd channels-example && \
    pip install -r ./requirements.txt

# database needs to be set up before web can start serving requests
CMD sleep 7 && exec python /opt/app/channels-example/manage.py runserver --noworker -v3 0.0.0.0:8000
