FROM ubuntu:18.04

# Install dependencies
RUN ["apt", "update"]
RUN ["apt", "install", "-y", "portaudio19-dev", "sox", "flac", "ffmpeg", "libttspico0", "libttspico-utils", "python3-pip", "ca-certificates", "python3-certifi"]
RUN ["pip3", "install", "pyaudio", "telepot", "SpeechRecognition", "sklearn"]
RUN ["pip3", "install", "wikipedia", "googlemaps", "spacex_py"]

# Downgrade urllib
# This is a temporary fix for the telegram module
# The following issue describes the problem:
# https://github.com/nickoala/telepot/issues/463
RUN ["pip3", "install", "urllib3==1.24.1"]

WORKDIR /home/tiane
COPY . ./

ENV PYTHONIOENCODING = utf-8
ENV PYTHONUNBUFFERED = 1

CMD ["python3", "/home/tiane/TIANE_server.py"]
