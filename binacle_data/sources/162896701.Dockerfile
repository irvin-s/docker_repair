FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update && \
    apt-get install --no-install-recommends -y build-essential \
    libsdl1.2-dev zlib1g-dev libsdl-mixer1.2-dev libsdl-image1.2-dev \
    git curl wget ca-certificates build-essential && \
    wget https://github.com/jwilder/dockerize/releases/download/v0.2.0/dockerize-linux-amd64-v0.2.0.tar.gz && \
    tar -C /usr/local/bin -xzvf dockerize-linux-amd64-v0.2.0.tar.gz

RUN git clone --recursive https://github.com/red-eclipse/base /redeclipse
RUN adduser --home /redeclipse redeclipse
WORKDIR /redeclipse
RUN chown redeclipse: -R /redeclipse
USER redeclipse
RUN git checkout v1.5.3 && \
    git submodule update && \
    cd src && \
    make clean && \
    make -j 4 && \
    make install

RUN mkdir -p /redeclipse/.redeclipse/
ADD ./server.conf /redeclipse.tmpl

ENV SERVER_PASS="" \
    ADMIN_PASS="" \
    SERVER_TYPE=1 \
    SERVER_MASTER="play.redeclise.net" \
    SERVER_MASTER_PORT=28800 \
    SV_AIRCOASTSCALE=1.0 \
    SV_AIREFRESHDELAY=1000 \
    SV_ALLOWLOCK=4 \
    SV_ALLOWMAPS="absorption abuse affluence ares bath battlefield biolytic bloodlust campgrounds canals canyon cargo castle center colony conflict condensation convolution cutec cyanide darkness deadsimple deathtrap decay decomposition deli depot dropzone dutility echo enyo erosion error escape futuresport ghost hinder institute keystone2k linear livefire longestyard mist neodrive nova octavus oneiroi panic processing pumpstation purge relax rooftop spacetech steelrat stone suspended testchamber tonatiuh tower tribal ubik vault venus wardepot warp wet" \
    SV_AUTOADMIN=0 \
    SV_BANLOCK=4 \
    SV_BLEEDDAMAGE=3 \
    SV_BLEEDDELAY=1000 \
    SV_BLEEDTIME=5500 \
    SV_BOMBERATTACKRESET=1 \
    SV_BOMBERBASKETMINDIST=48 \
    SV_BOMBERBASKETONLY=1 \
    SV_BOMBERBUFFDAMAGE=1.25 \
    SV_BOMBERBUFFDELAY=1000 \
    SV_BOMBERBUFFING=1 \
    SV_BOMBERBUFFSHIELD=1.25 \
    SV_BOMBERCARRYSPEED=0.9 \
    SV_BOMBERCARRYTIME=15000 \
    SV_BOMBERHOLDINTERVAL=1000 \
    SV_BOMBERHOLDLIMIT=0 \
    SV_BOMBERHOLDPENALTY=10 \
    SV_BOMBERHOLDTIME=15000 \
    SV_BOMBERLIMIT=0 \
    SV_BOMBERMAPS="affluence ares battlefield canals canyon cargo center conflict condensation convolution darkness deathtrap deli depot dropzone dutility echo enyo erosion futuresport linear mist nova octavus pumpstation stone suspended tower tribal vault venus warp wet" \
    SV_BOMBERPICKUPDELAY=5000 \
    SV_BOMBERREGENBUFF=1 \
    SV_BOMBERREGENDELAY=1000 \
    SV_BOMBERREGENEXTRA=2 \
    SV_BOMBERRESETDELAY=15000 \
    SV_BOTBALANCE=-1 \
    SV_BOTLIMIT=32 \
    SV_BOTSCALE=1.0 \
    SV_BOTSKILLMAX=75 \
    SV_BOTSKILLMIN=60 \
    SV_BURNDAMAGE=3 \
    SV_BURNDELAY=1000 \
    SV_BURNTIME=5500 \
    SV_CAPTUREBUFFDAMAGE=1.25 \
    SV_CAPTUREBUFFDELAY=3000 \
    SV_CAPTUREBUFFING=9 \
    SV_CAPTUREBUFFSHIELD=1.25 \
    SV_CAPTURECARRYSPEED=0.9 \
    SV_CAPTUREDEFENDDELAY=15000 \
    SV_CAPTURELIMIT=0 \
    SV_CAPTUREMAPS="affluence ares bath battlefield biolytic canals canyon center colony conflict condensation convolution darkness deadsimple deli depot dropzone dutility echo enyo erosion futuresport institute keystone2k linear mist nova octavus panic pumpstation stone suspended tribal vault venus warp wet" \
    SV_CAPTUREPICKUPDELAY=2500 \
    SV_CAPTUREPROTECTDELAY=15000 \
    SV_CAPTUREREGENBUFF=1 \
    SV_CAPTUREREGENDELAY=1000 \
    SV_CAPTUREREGENEXTRA=2 \
    SV_CAPTURERESETDELAY=30000 \
    SV_CAPTURERESETPENALTY=3500 \
    SV_CAPTURETEAMPENALTY=7500 \
    SV_COOPBALANCE=1.5 \
    SV_COOPMULTIBALANCE=2.0 \
    SV_COOPSKILLMAX=85 \
    SV_COOPSKILLMIN=75 \
    SV_CRCLOCK=8 \
    SV_DAMAGESCALE=1.0 \
    SV_DAMAGESELF=1 \
    SV_DAMAGETEAM=1 \
    SV_DEADPUSHSCALE=2.0 \
    SV_DEFAULTMAP="" \
    SV_DEFAULTMODE=2 \
    SV_DEFAULTMUTS=0 \
    SV_DEFENDBUFFDAMAGE=1.25 \
    SV_DEFENDBUFFDELAY=1000 \
    SV_DEFENDBUFFING=1 \
    SV_DEFENDBUFFSHIELD=1.25 \
    SV_DEFENDHOLD=100 \
    SV_DEFENDINTERVAL=50 \
    SV_DEFENDKING=100 \
    SV_DEFENDLIMIT=0 \
    SV_DEFENDMAPS="affluence ares bath battlefield biolytic campgrounds canals canyon cargo center colony conflict condensation convolution cutec darkness deadsimple deathtrap decay deli depot dropzone dutility echo enyo erosion futuresport ghost institute keystone2k linear livefire mist nova octavus panic processing rooftop stone suspended tower tribal ubik vault venus warp wet" \
    SV_DEFENDOCCUPY=100 \
    SV_DEFENDPOINTS=1 \
    SV_DEFENDREGENBUFF=1 \
    SV_DEFENDREGENDELAY=1000 \
    SV_DEFENDREGENEXTRA=2 \
    SV_DEMOAUTOREC=1 \
    SV_DEMOAUTOSERVERSAVE=0 \
    SV_DEMOCOUNT=5 \
    SV_DEMOLOCK=4 \
    SV_DEMOMAXSIZE=16 \
    SV_DEMOSERVERKEEPTIME=86400 \
    SV_DOMINATECOUNT=5 \
    SV_DUELCLEAR=1 \
    SV_DUELCOOLOFF=5000 \
    SV_DUELCYCLE=2 \
    SV_DUELCYCLES=2 \
    SV_DUELMAPS="abuse bath bloodlust campgrounds canyon cargo castle darkness deadsimple dutility echo error ghost livefire longestyard mist panic stone vault wet" \
    SV_DUELPROTECT=5000 \
    SV_DUELRESET=1 \
    SV_EDITLOCK=4 \
    SV_ENEMYBALANCE=1 \
    SV_ENEMYSKILLMAX=80 \
    SV_ENEMYSKILLMIN=65 \
    SV_ENEMYSPAWNDELAY=1000 \
    SV_ENEMYSPAWNSTYLE=1 \
    SV_ENEMYSPAWNTIME=30000 \
    SV_FLOODLINES=5 \
    SV_FLOODLOCK=4 \
    SV_FLOODMUTE=3 \
    SV_FLOODTIME=10000 \
    SV_FLOORCOASTSCALE=1.0 \
    SV_GAMEPAUSED=0 \
    SV_GAMESPEED=100 \
    SV_GAMESPEEDLOCK=5 \
    SV_GRAVITYSCALE=1.0 \
    SV_HITPUSHSCALE=1.0 \
    SV_HITSTUNSCALE=1.0 \
    SV_HOLDMAPS="affluence ares bath battlefield biolytic campgrounds canals canyon cargo center colony conflict condensation convolution cutec darkness deadsimple deathtrap decay deli depot dropzone dutility echo enyo erosion futuresport ghost keystone2k linear mist nova octavus panic pumpstation stone suspended tower tribal ubik vault venus warp wet" \
    SV_IMPULSEALLOWED=15 \
    SV_IMPULSEBOOST=1.0 \
    SV_IMPULSECOST=5000 \
    SV_IMPULSECOUNT=6 \
    SV_IMPULSEDASH=1.3 \
    SV_IMPULSEDELAY=250 \
    SV_IMPULSEJUMP=1.1 \
    SV_IMPULSELIMIT=0.0 \
    SV_IMPULSEMELEE=0.75 \
    SV_IMPULSEMETER=30000 \
    SV_IMPULSEPARKOUR=1.0 \
    SV_IMPULSEREGEN=5.0 \
    SV_IMPULSEREGENCROUCH=2.5 \
    SV_IMPULSEREGENINAIR=0.75 \
    SV_IMPULSEREGENMOVE=1.0 \
    SV_IMPULSEREGENPACING=0.75 \
    SV_IMPULSEREGENSLIDE=0.0 \
    SV_IMPULSESKATE=1000 \
    SV_IMPULSESLIDE=1000 \
    SV_IMPULSESPEED=90.0 \
    SV_IMPULSESPREAD=1.0 \
    SV_IMPULSESTYLE=1 \
    SV_INAIRSPREAD=2.0 \
    SV_INSTADELAY=3000 \
    SV_INSTAPROTECT=3000 \
    SV_INSTAWEAPON=8 \
    SV_INTERMLIMIT=15000 \
    SV_ITEMSALLOWED=2 \
    SV_ITEMSPAWNDELAY=1000 \
    SV_ITEMSPAWNSTYLE=1 \
    SV_ITEMSPAWNTIME=15000 \
    SV_ITEMTHRESHOLD=2.0 \
    SV_JUMPSPEED=110.0 \
    SV_KAMIKAZE=1 \
    SV_KICKLOCK=3 \
    SV_KICKPUSHCROUCH=0.0 \
    SV_KICKPUSHSCALE=1.0 \
    SV_KICKPUSHSWAY=0.0125 \
    SV_KICKPUSHZOOM=0.125 \
    SV_KINGMAPS="ares bath battlefield biolytic campgrounds canals canyon cargo center colony conflict condensation darkness depot dropzone dutility echo enyo linear livefire octavus processing pumpstation rooftop stone suspended tribal ubik vault venus" \
    SV_LIMITLOCK=3 \
    SV_LIQUIDCOASTSCALE=1.0 \
    SV_LIQUIDSPEEDSCALE=1.0 \
    SV_MAINMAPS="abuse affluence ares bath battlefield biolytic bloodlust campgrounds canals canyon cargo castle center colony conflict condensation convolution cutec darkness deadsimple deathtrap decay deli depot dropzone dutility echo enyo erosion error futuresport ghost institute keystone2k linear livefire longestyard mist nova octavus oneiroi panic processing pumpstation rooftop spacetech stone suspended tower tribal ubik vault venus warp wet" \
    SV_MAPHISTORY=5 \
    SV_MAPSLOCK=4 \
    SV_MAXCARRY=2 \
    SV_MAXHEALTH=1.5 \
    SV_MAXHEALTHVAMPIRE=3.0 \
    SV_MODELOCK=4 \
    SV_MODELOCKFILTER=60 \
    SV_MOVECRAWL=0.6 \
    SV_MOVEINAIR=0.9 \
    SV_MOVERUN=1.3 \
    SV_MOVESPEED=125.0 \
    SV_MOVESPREAD=1.0 \
    SV_MOVESTEPDOWN=1.15 \
    SV_MOVESTEPUP=0.95 \
    SV_MOVESTRAFE=1.0 \
    SV_MOVESTRAIGHT=1.2 \
    SV_MULTIKILLDELAY=5000 \
    SV_MULTIMAPS="canals condensation convolution deadsimple depot keystone2k suspended warp" \
    SV_MUTELOCK=3 \
    SV_MUTSLOCKFILTER=131071 \
    SV_MUTSLOCKFORCE=0 \
    SV_OVERTIMEALLOW=1 \
    SV_OVERTIMELIMIT=5 \
    SV_POINTLIMIT=0 \
    SV_RADIALLIMITED=0.75 \
    SV_RADIALSCALE=1.0 \
    SV_REGENDELAY=3000 \
    SV_REGENHEALTH=5 \
    SV_REGENTIME=1000 \
    SV_RESETALLOWSONEND=1 \
    SV_RESETBANSONEND=1 \
    SV_RESETLIMITSONEND=1 \
    SV_RESETMMONEND=2 \
    SV_RESETMUTESONEND=1 \
    SV_RESETVARSONEND=1 \
    SV_ROTATECYCLE=10 \
    SV_ROTATEMAPS=2 \
    SV_ROTATEMAPSFILTER=2 \
    SV_ROTATEMODE=1 \
    SV_ROTATEMODEFILTER=60 \
    SV_ROTATEMUTS=3 \
    SV_ROTATEMUTSFILTER=258 \
    SV_SERVERCLIENTS=16 \
    SV_SERVERDESC="My server" \
    SV_SERVERMOTD="Welcome to my server!" \
    SV_SERVEROPEN=3 \
    SV_SHOCKDAMAGE=2 \
    SV_SHOCKDELAY=1000 \
    SV_SHOCKTIME=5500 \
    SV_SLIDECOASTSCALE=1.0 \
    SV_SPAWNDELAY=5000 \
    SV_SPAWNEDITLOCK=3 \
    SV_SPAWNGRENADES=0 \
    SV_SPAWNHEALTH=100 \
    SV_SPAWNMINES=0 \
    SV_SPAWNPROTECT=3000 \
    SV_SPAWNROTATE=2 \
    SV_SPAWNWEAPON=1 \
    SV_SPECLOCK=3 \
    SV_SPREECOUNT=5 \
    SV_STILLSPREAD=0.0 \
    SV_TEAMBALANCE=1 \
    SV_TIMELIMIT=10 \
    SV_TRIALDELAY=500 \
    SV_TRIALDELAYEX=3000 \
    SV_TRIALMAPS="absorption cyanide decomposition escape hinder neodrive purge relax steelrat testchamber tonatiuh wardepot" \
    SV_TRIALWEAPON=0 \
    SV_VARSLOCK=4 \
    SV_VETOLOCK=4 \
    SV_VOTEINTERM=2 \
    SV_VOTELIMIT=45000 \
    SV_VOTELOCK=4 \
    SV_VOTESTYLE=2 \
    SV_VOTEWAIT=2500 \
    SV_WAVEPUSHSCALE=1.0 \
    LOCALOP="admin:a" \
    ADDBAN="" \
    ADDALLOW="" \
    ADDMUTE="" \
    ADDLIMIT="" \
    REDECLIPSE_BRANCH="inplace"

EXPOSE 28799 28800 28801 28802
RUN cd /redeclipse/src/ && make install
CMD dockerize -template /redeclipse.tmpl:/redeclipse/.redeclipse/servinit.cfg /redeclipse/redeclipse_server.sh
