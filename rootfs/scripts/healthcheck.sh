#!/usr/bin/env bash
#shellcheck shell=bash

# Import healthchecks-framework
source /opt/healthchecks-framework/healthchecks.sh

EXITCODE=0

# Ensure web server listening
if ! check_tcp4_socket_listening ANY 30005; then
    EXITCODE=1
fi

exit "$EXITCODE"
