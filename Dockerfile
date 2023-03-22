FROM ghcr.io/sdr-enthusiasts/docker-baseimage:base

COPY rootfs/ /

RUN set -x && \
    apt-get update -y && \
    apt-get install --no-install-recommends -y libusb-1.0-0 && \
    apt-get -v clean && \
    # Download airspy_adsb armhf binary
    curl \
      --location \
      --output /tmp/airspy_adsb-linux-arm.tgz \
      "https://airspy.com/?ddownload=3753" \
      && \
    # Download airspy_adsb arm64 binary
    curl \
      --location \
      --output /tmp/airspy_adsb-linux-arm64.tgz \
      "https://airspy.com/?ddownload=3753" \
      && \
    # Download airspy_adsb amd64 binary
    curl \
      --location \
      --output /tmp/airspy_adsb-linux-x86_64.tgz \
      "https://airspy.com/?ddownload=3758" \
      && \
    # Download airspy_adsb i386 binary
    curl \
      --location \
      --output /tmp/airspy_adsb-linux-i386.tgz \
      "https://airspy.com/?ddownload=6063" \
      && \
    # Extract armhf binary
    tar \
      xvf /tmp/airspy_adsb-linux-arm.tgz \
      -C /tmp \
      && \
    mv -v /tmp/airspy_adsb /usr/local/bin/airspy_adsb.armhf && \
    # Extract arm64 binary
    tar \
      xvf /tmp/airspy_adsb-linux-arm64.tgz \
      -C /tmp \
      && \
    mv -v /tmp/airspy_adsb /usr/local/bin/airspy_adsb.aarch64 && \
    # Extract amd64 binary
    tar \
      xvf /tmp/airspy_adsb-linux-x86_64.tgz \
      -C /tmp \
      && \
    mv -v /tmp/airspy_adsb /usr/local/bin/airspy_adsb.x86_64 && \
    # Extract i386 binary
    tar \
      xvf /tmp/airspy_adsb-linux-i386.tgz \
      -C /tmp \
      && \
    mv -v /tmp/airspy_adsb /usr/local/bin/airspy_adsb.i386 && \
    # Ensure all binaries are executable
    chmod -v a+x /usr/local/bin/airspy_adsb.*

EXPOSE 30005
