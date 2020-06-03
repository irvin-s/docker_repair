FROM alljoynsville/alljoyn-core  
  
MAINTAINER alljoynsville  
  
WORKDIR /root/alljoyn/core/alljoyn  
  
RUN scons BINDINGS=cpp WS=off BT=off ICE=off SERVICES="about"  
RUN scons BINDINGS=cpp WS=off BT=off ICE=off SERVICES="notification"  
RUN scons BINDINGS=cpp WS=off BT=off ICE=off SERVICES="controlpanel"  
RUN scons BINDINGS=cpp WS=off BT=off ICE=off SERVICES="config"  
RUN scons BINDINGS=cpp WS=off BT=off ICE=off SERVICES="onboarding"  
RUN scons BINDINGS=cpp WS=off BT=off ICE=off SERVICES="sample_apps"  

