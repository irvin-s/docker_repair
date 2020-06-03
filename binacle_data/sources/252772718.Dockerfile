FROM benoitleblanc/rust  
  
COPY src/hello_world.rs /rust/  
RUN rustc hello_world.rs  
CMD /rust/hello_world  
  

