FROM zookeeper:latest
MAINTAINER tomsun28 <usthe.com>

#zookeeper配置文件
COPY zoo.cfg /conf/zoo.cfg

