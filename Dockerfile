FROM ubuntu:22.04

ENTRYPOINT ["/init"]

RUN \
# Update and get dependencies
    apt-get update && \
    apt-get install -y \
      tzdata \
      curl \
    && \
    \
# Add user
    useradd -U -s /bin/false borg && \
    usermod -G borg && \
    \
# Setup directories
    mkdir -p \
      /BorgBackup \
    && \
    \
# Cleanup
    apt-get -y autoremove && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/*

EXPOSE 22/tcp
VOLUME /BorgBackup

#ENV CHANGE_CONFIG_DIR_OWNERSHIP="true" \
#    HOME="/config"

#ARG TAG=beta
#ARG URL=

#COPY root/ /

#RUN \
# Save version and install
    /installBinary.sh

#HEALTHCHECK --interval=5s --timeout=2s --retries=20 CMD /healthcheck.sh || exit 1
