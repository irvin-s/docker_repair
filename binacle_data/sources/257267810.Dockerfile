# 이것은 개발단계에서 시험에 쓰인 것 입니다. KB만 됩니다.
FROM ubuntu:14.04.5
ENV TERM xterm
COPY test /test
WORKDIR /test
#업데이트 및 Firefox 설치
RUN apt-get update && apt-get install -y firefox
#한국어 설정
RUN apt-get install -y fonts-nanum
RUN localedef -f UTF-8 -i ko_KR ko_KR.UTF-8
ENV LANG="ko_KR.UTF-8"

#DESKTOP 환경 구성
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    hicolor-icon-theme \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libpulse0 \
    libv4l-0 \
    --no-install-recommends

#test
RUN apt-get update && apt-get install -y gdebi && apt-get update
RUN cd /test && gdebi astx_u64.deb && gdebi delfino-g3_amd64.deb && gdebi delfino-g3_amd64.deb

#사용자 계정 설정
USER root

