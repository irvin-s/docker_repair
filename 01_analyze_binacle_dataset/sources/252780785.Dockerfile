FROM baden/erlang  
  
RUN mkdir /app  
  
WORKDIR /app  
  
RUN wget https://erlang.mk/erlang.mk  
  
ADD Makefile.docker ./Makefile  
ADD relx.config ./relx.config  
ADD src ./src  
ADD test ./test  
ADD rel ./rel  
  
RUN make  
  
ENV RUNNER_LOG_DIR="log"  
EXPOSE 8981  
EXPOSE 8982  
EXPOSE 8983  
ENTRYPOINT _rel/navicc-server/bin/navicc-server console  
# CMD ["_rel/navicc-server/bin/navicc-server", "foreground"]  
CMD ["/app/_rel/navicc-server/bin/navicc-server", "console"]  
# CMD ["bash"]  

