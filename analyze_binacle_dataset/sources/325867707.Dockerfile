FROM ufoym/deepo:all-jupyter-py36-cu90

COPY install_julia_package.jl /
# ===== ssh service =====
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt update && \
    apt install -y openssh-server openssh-client && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

RUN wget -O julia_bin.tar.gz https://julialang-s3.julialang.org/bin/linux/x64/0.7/julia-0.7.0-linux-x86_64.tar.gz && \
    tar xzf julia_bin.tar.gz

RUN ./julia-0.7.0/bin/julia -e "ENV[\"JUPYTER\"]=\"jupyter\"; using Pkg; Pkg.resolve(); Pkg.add(\"IJulia\")" && \
    ./julia-0.7.0/bin/julia /install_julia_package.jl

ENV PATH=/julia-0.7.0/bin:$PATH
