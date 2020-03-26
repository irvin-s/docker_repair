FROM erlang:20  
RUN git clone https://github.com/elixir-lang/elixir.git  
  
RUN cd elixir && make clean compile  
  
ENV PATH=/elixir/bin:$PATH  
  
CMD ["iex"]

