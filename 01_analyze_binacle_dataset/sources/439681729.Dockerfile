FROM nitnelave/poseidon-dependencies

RUN cd /poseidon && make all -j$(nproc)

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
