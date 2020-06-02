FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive
ENV EXPORTER_BASEDIR /opt/libvirt_exporter/

RUN mkdir ${EXPORTER_BASEDIR}

RUN apt-get update && apt-get install -y libvirt-dev curl git gcc python3 \
    python3-pip && apt-get clean all


# RUN apt-get update && apt-get install -y libvirt-bin && apt-get clean all
ADD requirements.txt libvirt_exporter.py ${EXPORTER_BASEDIR}/
WORKDIR ${EXPORTER_BASEDIR}
RUN pip3 install -r requirements.txt

CMD [ "python3", "./libvirt_exporter.py" ]