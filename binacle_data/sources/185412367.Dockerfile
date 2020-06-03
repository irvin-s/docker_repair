FROM java:8

ENV TZ Europe/Copenhagen
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN wget --progress=bar "https://dma.ci.cloudbees.com/job/MaritimeCloud/lastSuccessfulBuild/artifact/*zip*/archive.zip" -O /archive.zip
RUN unzip /archive.zip -d /
ADD ./start.sh /start.sh
EXPOSE 43234 43235
CMD ["/bin/bash", "/start.sh"]
