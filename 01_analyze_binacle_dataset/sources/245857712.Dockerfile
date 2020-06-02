FROM microsoft/aspnetcore-build:1.1

LABEL Comment="Standard microsoft/aspnetcore:latest image with a custom CA web application hosted on port 80." \
      Author="Division42 LLC" \
      ImageRepo="https://github.com/Division42LLC/division42llc-dotnet-webca"

COPY docker-entrypoint.sh /usr/local/bin
COPY . /src/

ADD app-name.txt /app/
ADD app-version.txt /app/
ADD sample-cert.pfx /var/localCA/CA/
ADD sample-cert.pfx /var/localCA/leaf/

RUN cd /src && \
	echo "[*] Building App: dotnet RESTORE starting..." && \
	dotnet restore && \
	echo "[*] Building App: dotnet RESTORE completed." && \
	echo "[*] Building App: dotnet BUILD starting..." && \
	cd ./Division42LLC.WebCA.UIWeb && \
	dotnet build ./Division42LLC.WebCA.UIWeb.csproj  && \
	echo "[*] Building App: dotnet BUILD completed." && \
	echo "[*] Building App: dotnet PUBLISH starting..." && \
	dotnet publish ./Division42LLC.WebCA.UIWeb.csproj -c Release -o /app && \
	echo "[*] Building App: dotnet PUBLISH completed." && \
	cd /app && \
	echo "[*] Configuring app [IMAGE_NAME]..." && \
	export IMAGE_NAME=`cat /src/app-name.txt` && \
	echo "export IMAGE_NAME=$IMAGE_NAME" >> /etc/profile && \
	echo "[*] Configuring app [IMAGE_VERSION]..." && \
	export IMAGE_VERSION=`cat /src/app-version.txt` && \
	echo "export IMAGE_VERSION=$IMAGE_VERSION" >> /etc/profile && \
	echo "export IMAGE_BUILT=\"`date`\"" >> /etc/profile && \
	echo "[*] Purging source code..." && \
	rm -rf /src && \
	echo "[*] Updating Aptitude..." && \
	apt-get update && \
	echo "[*] Installing packages: nano figlet" && \
	apt-get install nano figlet -y && \
	DISK_SPACE_BEFORE=`df -hm | grep "/$" | xargs | cut -d " " -f3` && \
	echo "[*] Clearing Aptitude cache..." && \
	apt-get clean -y && \
	apt-get purge -y && \
	rm -rf /var/lib/apt/lists/* && \
	echo "[*] Wiping system log files to reduce image size." && \
	cat /dev/null > /var/log/alternatives.log && \
	cat /dev/null > /var/log/apt/history.log && \
	cat /dev/null > /var/log/apt/term.log && \
	cat /dev/null > /var/log/bootstrap.log && \
	cat /dev/null > /var/log/btmp && \
	cat /dev/null > /var/log/dmesg && \
	cat /dev/null > /var/log/dpkg.log && \
	cat /dev/null > /var/log/faillog && \
	cat /dev/null > /var/log/lastlog && \
	cat /dev/null > /var/log/wtmp && \
	DISK_SPACE_AFTER=`df -hm | grep "/$" | xargs | cut -d " " -f3` && \
	echo "[*] Build run commands finished. [$(($DISK_SPACE_BEFORE - DISK_SPACE_AFTER))mb recovered]" && \
	echo "[*] Setting permissions on /var/localCA" && \
	mkdir -p /var/localCA/ && \
	chmod -R 777 /var/localCA

    

WORKDIR /app

EXPOSE 8080
VOLUME /var/localCA

USER 1001

ENTRYPOINT ["/bin/bash", "/usr/local/bin/docker-entrypoint.sh"]

CMD ["dotnet", "Division42LLC.WebCA.UIWeb.dll"]
