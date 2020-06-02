FROM archlinux/base  
  
RUN pacman -Syu --noconfirm  
RUN pacman -S gcc gdb --noconfirm  
  
RUN mkdir -p /app  
COPY main.c /app/  
WORKDIR /app  
RUN gcc -g main.c -Wall  
RUN chmod +x a.out  
EXPOSE 1024  
CMD ["./a.out"]

