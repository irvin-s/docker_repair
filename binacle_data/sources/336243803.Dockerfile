FROM ocaml/opam:ubuntu

USER root

# Install OCaml toolchain
RUN apt-get install -y libgmp-dev
RUN opam update && \
  opam switch 4.02.3+buckle-master && \
  echo "eval `opam config env`" > /etc/profile.d/opam.sh
# Install Reason   
RUN opam install -y reason merlin re
# Install dependencies
RUN opam install -y tls cohttp ezjsonm 

# Install Nodejs toolchain 
RUN (curl -sL https://deb.nodesource.com/setup_6.x | bash -) && \
  apt-get install -y nodejs --no-install-recommends && \
  apt-get clean

# Get example code
WORKDIR /home
RUN git clone https://github.com/voila/reason-client-server-example.git

# Compile client
WORKDIR /home/reason-client-server-example/client
RUN npm install
RUN npm run build
RUN npm run webpack2


# Compile server
WORKDIR /home/reason-client-server-example/server
ENV PATH /home/opam/.opam/4.02.3+buckle-master/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV CAML_LD_LIBRARY_PATH /home/opam/.opam/4.02.3+buckle-master/lib/stublibs
RUN make build
ENV DARKSKY_API_KEY <YOUR_KEY_HERE>
ENTRYPOINT ./main.byte
EXPOSE 8000