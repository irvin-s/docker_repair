FROM registry.cubos.io/cubos/android-builder
WORKDIR /root
ADD . /root/
RUN ./gradlew assembleDebug
ADD build_and_publish.sh /
RUN chmod +x /build_and_publish.sh