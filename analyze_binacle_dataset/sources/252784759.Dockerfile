FROM gcc  
  
RUN apt-get update && apt-get install -y \  
binutils-arm-none-eabi \  
cmake \  
gcc-arm-none-eabi  

