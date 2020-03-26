FROM gcc:4.9  
COPY . /balancedParens  
WORKDIR /balancedParens  
RUN g++ -std=c++11 -o balanced balanced.cpp  
CMD ["./balanced"]

