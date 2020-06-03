FROM progrium/busybox  
COPY panamax-remote-agent-go /  
COPY db /db  
ENTRYPOINT ["/panamax-remote-agent-go"]  

