FROM node:carbon  
  
# Diretorio de exec. da aplicacao  
WORKDIR /usr/src/app  
  
# Copiando dependencias  
COPY package.json ./  
  
# Instalando dependencias  
RUN npm install  
  
# Copiar tudo que esta no diretorio corrente para o $WORKDIR  
COPY . .  
  
# Porta onde a aplicacao recebe conexoes  
EXPOSE 8080  
# Execucao sa aplicacao usando CMD (Comando a ser executado pelo container)  
CMD [ "npm", "start" ]  

