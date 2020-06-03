FROM ubuntu:latest

MAINTAINER Connor Lanigan <dev@connorlanigan.com>

RUN apt-get update && apt-get install -y git sudo tzdata && rm -rf /var/lib/apt/lists/*

CMD git clone --depth=1 https://github.com/EpicGames/UnrealEngine.git && \
	cd UnrealEngine && \
	apt-get update && \
	./Setup.sh && \
	./GenerateProjectFiles.sh && \
	make && \
	chmod 777 ../  # Allows the users on the outside to delete the folder
