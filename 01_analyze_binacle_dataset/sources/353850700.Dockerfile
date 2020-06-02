FROM openjdk:alpine

RUN mkdir -p /otinanai/gr/phaistosnetworks/admin/otinanai
WORKDIR /otinanai

ADD src src/
ADD web web/
ADD jars jars/

RUN javac -d . -cp .:jars/* src/*.java

ENTRYPOINT ["java","-Xms64m","-Xmx512m","-cp",".:jars/*","gr.phaistosnetworks.admin.otinanai.OtiNanai","-lf","/dev/null","-rh","redis","-notify","/bin/echo"]

