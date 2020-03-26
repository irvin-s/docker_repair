FROM burgerdev/ocaml-build:4.06-0 as build  
  
RUN opam install cohttp-lwt-unix  
  
# 17.12 syntax  
# ADD --chown=opam:nogroup . repo  
ADD . repo  
RUN sudo chown -R opam:nogroup repo  
  
RUN cd repo && echo "(-cclib -static)" >bin/link_flags && \  
eval `opam config env` && jbuilder build  
  
FROM scratch  
  
COPY \--from=build /home/opam/repo/_build/default/bin/main.exe /test-server  
  
USER 1  
  
EXPOSE 8080  
  
ENTRYPOINT ["/test-server", "--bind", "0.0.0.0"]  

