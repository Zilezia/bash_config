#!/bin/bash
nano_formatter() {
    sed 's/->/→/g'
}
if [[ ${BASH_SOURCE[0]} == ${0} ]]; then nano_formatter "$@"; fi
