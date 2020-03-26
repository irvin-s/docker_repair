from dabbertorres/sfml-ubuntu-16.04  
# build  
workdir /build  
run git clone https://github.com/SFML/CSFML.git  
workdir /build/CSFML/build  
run cmake -DCMAKE_MODULE_PATH=/usr/local/share/SFML/cmake/Modules ..  
run make install  
  
# cleanup  
workdir /  
run rm -r /build  

