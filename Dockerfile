FROM ubuntu:14.04
MAINTAINER camilo@camilo.fm

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker && \

# Let's start with some basic stuff.
    apt-get update -qq && apt-get install -qqy \
        apt-transport-https \
        ca-certificates \
        curl \
        lxc \
        iptables \
        dmsetup && \

# Install Docker from Docker Inc. repositories.
    curl -sSL https://get.docker.com/ | sh && \
    apt-get remove -qqy \
        apparmor \
        git && \

# Clean some unnecessary files
    apt-get autoremove -qqy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Define additional metadata for our image.
VOLUME /var/lib/docker
CMD ["wrapdocker"]
