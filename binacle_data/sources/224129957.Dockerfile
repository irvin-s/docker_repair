# OpenAI Gym over VNC
FROM eboraas/openai-gym
RUN apt-get update
RUN apt-get install -y x11vnc xvfb
RUN mkdir /.vnc
RUN x11vnc -storepasswd 9487 /.vnc/passwd

