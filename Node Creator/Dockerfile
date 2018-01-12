# .         Dockerfile
# ------------------------------------------------------------------
# Needed:
#       - Docker
# ------------------------------------------------------------------
# Purpose: Create Quorum Image
# ------------------------------------------------------------------
# Creator Name: Mickael Labarrere
# Email Address: mickael.labarrere at gmail.com
# Comment:
# ------------------------------------------------------------------
FROM ubuntu

###################### COMMON INSTALL ######################
RUN apt-get update && \
    apt-get install -y  software-properties-common jq

###################### BOOTNODE INSTALL ######################
RUN apt-get update && \
    apt-get -y install grep iproute2

RUN mkdir -p qdata/logs/
COPY src/launchbootnode.sh .
EXPOSE 33445

###################### QUORUM INSTALL ######################
# Copy binaries to image's /bin/ repository
COPY bin/* /bin/

# Copy data to image's /data_ey/ repository
COPY data_ey/ /

# Copy binaries to image's /bin/ repository
COPY src/* /

#RUN ./build01_quorum_setup.sh
RUN apt-get -y update && \
	apt-get -y install software-properties-common wget git

RUN add-apt-repository -y ppa:ethereum/ethereum && \
	apt-get -y update && \
	apt-get install -y build-essential unzip libdb-dev libsodium-dev zlib1g-dev libtinfo-dev solc sysvbanner wrk

# Install Constellation
RUN apt-get -y update && \
	wget -q https://github.com/jpmorganchase/constellation/releases/download/v0.0.1-alpha/ubuntu1604.zip && \
	unzip /ubuntu1604.zip && \
	chmod 777 /ubuntu1604/* &&\
	cp /ubuntu1604/* /bin/ &&\
	rm -rf /ubuntu1604.zip


#RUN ./build02_quorum_install.sh
RUN echo "[*] Cleaning up temporary data directories" && \
	rm -rf /qdata && \
	mkdir -p /qdata/logs && \
	echo "[*] Configuring node 2 as block maker and voter" && \
	mkdir -p /qdata/dd/keystore && \
	cp keys/* /qdata/dd/keystore && \
	geth --datadir /qdata/dd init /genesis.json


#For RPC
EXPOSE 22000

#For Port
EXPOSE 21000

#For Constellation
EXPOSE 9000

###################### CAKESHOP INSTALL ######################
RUN \
  apt-get update && \
  apt-get install -y openjdk-8-jdk && \
  rm -rf /var/lib/apt/lists/* && \
  apt-get -y clean

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-7-openjdk-amd64

# Cakeshop is run with user `cakeshop`, uid = 1000
ARG user=cakeshop
ARG group=cakeshop
ARG uid=1000
ARG gid=1000

ENV CAKESHOP_USER=$user
ENV CAKESHOP_GROUP=$group
ENV CAKESHOP_HOME /opt/cakeshop

# tini as PID 1
# gosu to drop privs
ENV TINI_VERSION 0.11.0
ENV TINI_SHA 7c18e2d8fb33643505f50297afddc8bcac5751c8a219932143405eaa4cfa2b78
ENV GOSU_VERSION 1.10

# Cakeshop data directory is a volume, so it can be persisted and
# survive image upgrades
VOLUME $CAKESHOP_HOME/data

# for main web interface:
EXPOSE 8080

# will be used by attached slave agents:
EXPOSE 8102

RUN ./build03_cakeshop_setup.sh

# entrypoint script can't use variables, so install to /usr/local/bin
COPY src/ey_CAT_start.sh /ey_CAT_start.sh

RUN apt-get -y autoclean && apt-get -y clean

#ENTRYPOINT ["/bin/bash", "--", "/ey_CAT_start.sh"]
