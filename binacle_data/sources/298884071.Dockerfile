FROM ubuntu:xenial

VOLUME /service/build
WORKDIR /service/build

ENTRYPOINT ["qemu-system-x86_64", "-nographic", "-smp", "1", "-m", "128", "-net", "nic,model=virtio", "-net", "user", "-kernel", "./chainloader", "-initrd"]
