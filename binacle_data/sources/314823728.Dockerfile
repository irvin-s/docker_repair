FROM fedora:26

USER root
RUN mkdir -p /opt/app-root/
RUN mkdir -p /opt/app-root/cfg

ADD . /opt/app-root

ADD https://pjreddie.com/media/files/yolov2.weights /opt/app-root/yolo.weights
ADD https://raw.githubusercontent.com/pjreddie/darknet/master/cfg/yolov2.cfg /opt/app-root/yolo.cfg
ADD https://raw.githubusercontent.com/pjreddie/darknet/master/data/coco.names /opt/app-root/cfg/

WORKDIR /opt/app-root

RUN INSTALL_PKGS="python3 libstdc++ python3-devel python3-setuptools python3-pip libSM libXrender libXext" && \
        yum -y --setopt=tsflags=nodocs install $INSTALL_PKGS && \
        yum -y clean all --enablerepo='*'&& \
        pip3 install -r /opt/app-root/requirements.txt && \
        pip3 install /opt/app-root/darkflow-1.0.0-cp36-cp36m-linux_x86_64.whl && \
        rm /opt/app-root/requirements.txt

RUN chmod 777 /opt/app-root /opt/app-root/ /opt/app-root/* /opt/app-root/cfg /opt/app-root/cfg/*
RUN chmod 755 /opt/app-root/app.py
RUN chown 185 /opt/app-root

EXPOSE 8080

LABEL io.k8s.description="image processor" \
      io.k8s.display-name="image-processor-service" \
      io.openshift.expose-services="8080:http" 

USER 185

ENTRYPOINT ["python3"]

CMD ["./app.py"]