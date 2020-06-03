FROM ubuntu:xenial

RUN apt-get update && apt-get install -y git sudo libudev-dev wget \
		mesa-utils unzip build-essential software-properties-common \
		cmake libxdamage1 && rm -rf /var/lib/apt/lists/*

ENV TZ America/New_York
RUN echo $TZ > /etc/timezone && \
    apt-get update && apt-get install -y tzdata && \
    rm /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

RUN useradd -ms /bin/bash unreal && \
	echo "unreal:unreal" | chpasswd && \
	adduser unreal sudo && \
	echo "unreal ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
USER unreal
WORKDIR /home/unreal

COPY UnrealEngine-4.17.zip ./
ADD *.patch ./

RUN git clone https://github.com/Microsoft/AirSim.git && \
	cd AirSim && git checkout 384e7555530601ad311d23f8bd6d87878d1f42d5 && \
	cd Unreal/Plugins/AirSim/Source && patch -p0 < ~/blueprint.patch
RUN cd AirSim && ./setup.sh && ./build.sh

RUN unzip UnrealEngine-4.17.zip && rm UnrealEngine-4.17.zip
RUN cd UnrealEngine-4.17/Engine/Source/Programs/UnrealBuildTool/Linux && \
	patch -p0 < ~/ltc4.patch 
RUN cd UnrealEngine-4.17 && \
	./Setup.sh && \
	./GenerateProjectFiles.sh -project="/home/unreal/AirSim/Unreal/Environments/Blocks/Blocks.uproject" -game -engine

RUN cd AirSim/Unreal/Environments/Blocks && ~/UnrealEngine-4.17/Engine/Build/BatchFiles/RunUAT.sh BuildCookRun -project="$PWD/Blocks.uproject" -platform=Linux -clientconfig=Shipping -cook -allmaps -build -stage -pak -archive -archivedirectory="/home/unreal/out"
