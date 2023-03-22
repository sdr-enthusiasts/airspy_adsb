FROM ghcr.io/sdr-enthusiasts/docker-baseimage:base

COPY rootfs/ /

RUN set -x && \
    #
    # Install libusb
    apt-get update -y && \
    apt-get install --no-install-recommends -y libusb-1.0-0 && \
    #
    # Download airspy_adsb arm binary
    curl \
      --location \
      --output /tmp/airspy_adsb-linux-arm.tgz \
      "https://github.com/wiedehopf/airspy-conf/raw/master/buster/airspy_adsb-linux-arm.tgz" \
      && \
    tar \
      xvf /tmp/airspy_adsb-linux-arm.tgz \
      -C /tmp \
      && \
    mv -v /tmp/airspy_adsb /usr/local/bin/airspy_adsb.arm && \
    #
    # Download airspy_adsb arm64 binary
    curl \
      --location \
      --output /tmp/airspy_adsb-linux-arm64.tgz \
      "https://github.com/wiedehopf/airspy-conf/raw/master/buster/airspy_adsb-linux-arm64.tgz" \
      && \
    tar \
      xvf /tmp/airspy_adsb-linux-arm64.tgz \
      -C /tmp \
      && \
    mv -v /tmp/airspy_adsb /usr/local/bin/airspy_adsb.arm64 && \
    #
    # Download airspy_adsb armv7 binary
    curl \
      --location \
      --output /tmp/airspy_adsb-linux-armv7.tgz \
      "https://github.com/wiedehopf/airspy-conf/raw/master/buster/airspy_adsb-linux-armv7.tgz" \
      && \
    tar \
      xvf /tmp/airspy_adsb-linux-armv7.tgz \
      -C /tmp \
      && \
    mv -v /tmp/airspy_adsb /usr/local/bin/airspy_adsb.armv7 && \
    #
    # Download airspy_adsb i386 binary
    curl \
      --location \
      --output /tmp/airspy_adsb-linux-i386.tgz \
      "https://github.com/wiedehopf/airspy-conf/raw/master/buster/airspy_adsb-linux-i386.tgz" \
      && \
    tar \
      xvf /tmp/airspy_adsb-linux-i386.tgz \
      -C /tmp \
      && \
    mv -v /tmp/airspy_adsb /usr/local/bin/airspy_adsb.i386 && \
    #
    # Download airspy_adsb nehalem binary
    curl \
      --location \
      --output /tmp/airspy_adsb-linux-nehalem.tgz \
      "https://github.com/wiedehopf/airspy-conf/raw/master/buster/airspy_adsb-linux-nehalem.tgz" \
      && \
    tar \
      xvf /tmp/airspy_adsb-linux-nehalem.tgz \
      -C /tmp \
      && \
    mv -v /tmp/airspy_adsb /usr/local/bin/airspy_adsb.nehalem && \
    #
    # Download airspy_adsb x86_64 binary
    curl \
      --location \
      --output /tmp/airspy_adsb-linux-x86_64.tgz \
      "https://github.com/wiedehopf/airspy-conf/raw/master/buster/airspy_adsb-linux-x86_64.tgz" \
      && \
    tar \
      xvf /tmp/airspy_adsb-linux-x86_64.tgz \
      -C /tmp \
      && \
    mv -v /tmp/airspy_adsb /usr/local/bin/airspy_adsb.x86_64 && \
    #
    # Ensure all binaries are executable
    chmod -v a+x /usr/local/bin/airspy_adsb.* && \
    #
    # Clean-up
    apt-get -v clean && \
    rm -rfv /tmp/* /var/lib/apt/lists/*

EXPOSE 30005

HEALTHCHECK --interval=60s --timeout=60s --start-period=30s --retries=3 CMD [ "/scripts/healthcheck.sh" ]
