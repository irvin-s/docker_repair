# Copyright 2017 Aldrin J D'Souza.  
# Licensed under the MIT License <https://opensource.org/licenses/MIT>  
FROM rust  
RUN cargo install mdbook  
VOLUME /src  
CMD ["sh", "-c", "cd /src && mdbook build"]  

