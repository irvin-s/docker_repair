# Building frontend  
FROM node:10 as frontend  
COPY . /interiovr  
WORKDIR /interiovr  
RUN npm install  
RUN npm run build  
  
# Building backend  
FROM rust:1.26  
COPY \--from=frontend /interiovr /interiovr  
WORKDIR /interiovr  
RUN cargo build --release  
  
EXPOSE 3000  
CMD ["./target/release/interiovr", "localhost:3000"]  

