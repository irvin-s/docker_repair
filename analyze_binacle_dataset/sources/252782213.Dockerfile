FROM nimmis/spigot  
  
# 최신 라즈베리 주스 플러그인을 빌드하고, plugins 디렉토리에 복사  
RUN mkdir -p /minecraft/plugins && \  
cd /minecraft/plugins && \  
git clone https://github.com/zhuowei/RaspberryJuice && \  
cd RaspberryJuice && \  
apt-cache search maven && \  
apt-get install -y maven && \  
mvn package && \  
cp /minecraft/plugins/RaspberryJuice/target/rasp* /minecraft/plugins/  
  
# 라즈베리 주스의 설정파일을 복사  
COPY resource/config.yml /minecraft/plugins/RaspberryJuice/config.yml  
  
# 라즈베리 주스의 통신 포트를 개방  
EXPOSE 4711

