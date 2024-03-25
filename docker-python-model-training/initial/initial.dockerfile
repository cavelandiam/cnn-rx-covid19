FROM ubuntu:22.04 

SHELL [ "/bin/bash", "-c" ]
ENV DEBIAN_FRONTEND=noninteractive
RUN echo "APT::Get::Assume-Yes \"true\";" > /etc/apt/apt.conf.d/90assumeyes

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends lsb-release sudo apt-utils dos2unix build-essential ca-certificates curl jq git iputils-ping libcurl4 libunwind8 netcat wget software-properties-common lsb-release lsb-core sqlite sqlite3 gnupg dnsutils file ftp iproute2 locales openssh-client rsync shellcheck telnet time zip unzip tzdata libxkbfile-dev pkg-config libsecret-1-dev libxss1 libgconf-2-4 dbus xvfb libgtk-3-0 fakeroot dpkg rpm xz-utils xorriso zsync nano tree net-tools make sshpass \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

    
# Update timezone
ENV TZ='America/Bogota'
RUN echo $TZ > /etc/timezone && \
    rm -rf /etc/localtime && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    apt-get clean

# Create environment variables for scripts   
ENV SCRIPTS_PATH=/tmp/scripts
# ENV AGENTS_PATH=$SCRIPTS_PATH/agents
ENV AGENT_TYPE=INITIAL
ENV AZP_PATH=/azp

# Create environment variables for scripts
ENV SCRIPTS_PATH=/tmp/scripts
ENV AGENT_TYPE=INITIAL

# # Copy and execute installers
COPY . $SCRIPTS_PATH
#RUN ls -lrta $SCRIPTS_PATH
# RUN chmod +x $SCRIPTS_PATH/**/*.sh && chmod +x $SCRIPTS_PATH/*.sh
RUN $SCRIPTS_PATH/initial.sh

# Create folder for Compilation Agents
RUN mkdir -p $AZP_PATH

# Remove installed scripts and temporary files
RUN rm -rf /tmp/*

WORKDIR $     

# CMD /pre-start.sh