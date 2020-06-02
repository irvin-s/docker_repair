FROM java:8-jre

# set timezone.
RUN TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# set language.
RUN echo "export LC_ALL=zh_CN.UTF-8" >> /etc/profile
ENV LANG="zh_CN.UTF-8"

# Set environment variable
ENV ARGS = ""

# add app
ADD ./target/cloud-zipkin.jar /app/

# run environment variable
#CMD ["java", "-Xmx200m", "-jar", "/app/cloud-zipkin.jar", "$ARGS"]
ENTRYPOINT ["sh","-c","java -Xmx200m -jar /app/cloud-zipkin.jar $ARGS"]

# expose
EXPOSE 22