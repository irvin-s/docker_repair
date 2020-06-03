FROM arnaudbonnet/rust_comp  
  
MAINTAINER arnaudbonnet@outlook.fr  
  
ADD src/hello_world.rs /rust/  
  
RUN rustc hello_world.rs  
CMD /rust/hello_world  

