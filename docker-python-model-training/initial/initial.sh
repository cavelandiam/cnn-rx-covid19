#!/bin/bash
################################################################################
##  File:  base.sh
##  Team:  CI-Platform
##  Desc:  Call the installer files set in this file
################################################################################

setEnvVar() {
    echo $1 >> /etc/environment
}
writeFeature() {
    if [ ! -d "$AZP_PATH" ]; then
        mkdir -p $AZP_PATH
    fi
    echo $1 >> $AZP_PATH/agentFeatures.md
}

powershell() {
    apt-get update
    apt update &&  apt upgrade
    apt install curl apt-transport-https gnupg2 -y
    apt-get install -y --no-install-recommends wget apt-transport-https software-properties-common

    echo "deb [arch=amd64,armhf,arm64 signed-by=/usr/share/keyrings/powershell.gpg] \
    https://packages.microsoft.com/ubuntu/20.04/prod focal main" \
    | sudo tee /etc/apt/sources.list.d/powershell.list

    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor | sudo tee /usr/share/keyrings/powershell.gpg >/dev/null

    apt-get update
    apt install powershell -y

    writeFeature '- Powershell'
}

webDrivers() {
    mkdir -p /tmp/google-chrome
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
    wget https://dl.google.com/linux/linux_signing_key.pub -P /tmp/google-chrome
    apt-key add /tmp/google-chrome/linux_signing_key.pub
    apt-get update
    apt-get install -y --no-install-recommends google-chrome-stable

    wget https://chromedriver.storage.googleapis.com/114.0.5735.90/chromedriver_linux64.zip-P /tmp/google-chrome
    unzip /tmp/google-chrome/chromedriver_linux64.zip -d /opt/web-drivers

    apt-get install -y --no-install-recommends firefox
    mkdir -p /tmp/firefox
    wget https://github.com/mozilla/geckodriver/releases/download/v0.34.0/geckodriver-v0.34.0-linux64.tar.gz -P /tmp/firefox
    tar xzfv /tmp/firefox/geckodriver-v0.34.0-linux64.tar.gz -C /opt/web-drivers

    chmod +x /opt/web-drivers/*

    setEnvVar 'WEBDRIVERS_HOME="/opt/web-drivers"'
    setEnvVar 'PATH="$WEBDRIVERS_HOME:$PATH"'
    writeFeature '- Google Chrome Web Driver'
    writeFeature '- Firefox Web Driver'
}

docker() {
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    apt-get update
    apt-get install -y --no-install-recommends docker-ce docker-ce-cli containerd.io

    writeFeature '- Docker'
}

dockerCompose() {
    LATEST_VERSION=`curl --silent "https://api.github.com/repos/docker/compose/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")'`
    wget "https://github.com/docker/compose/releases/download/$(echo $LATEST_VERSION)/docker-compose-$(uname -s)-$(uname -m)" -P /tmp/docker-compose

    mv "/tmp/docker-compose/docker-compose-$(uname -s)-$(uname -m)" "/usr/local/bin/docker-compose"
    chmod +x "/usr/local/bin/docker-compose"

    writeFeature '- Docker Compose'
}

python() {
    apt update
    apt install -y build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget python3-pip
    mkdir -p /tmp/python
    wget https://www.python.org/ftp/python/3.9.18/Python-3.9.18.tgz -P /tmp/python
    tar xzfv /tmp/python/Python-3.9.18.tgz -C /tmp/python
    cd /tmp/python/Python-3.9.18 && ./configure --enable-optimizations --prefix=/usr/local && make -j $(nproc) && sudo make altinstall

    python3.9 --version
    pip3 --version
    # pip install tensorflow==2.14 numpy==1.26.0 pydot graphviz
    # pip list | grep -i -E 'tensorflow|numpy|pydot|graphviz'

    writeFeature '- Python'
}

packages() {
    apt update
    pip install tensorflow==2.14
    pip install numpy==1.26.0
    pip install pydot
    pip install graphviz
    pip install flask-restful
    pip list | grep -i -E 'tensorflow|numpy|pydot|graphviz|flask-restful'

}

aptget(){
    apt-get update && apt-get clean && rm -rf /var/lib/apt/lists/*
}

# Install all the installer files
powershell
webDrivers
docker
dockerCompose
python
packages
aptget

