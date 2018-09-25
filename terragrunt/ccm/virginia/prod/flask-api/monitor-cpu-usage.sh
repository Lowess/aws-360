#!/usr/bin/env bash

# source the metrics
eval "$(curl -s $1:19999/api/v1/allmetrics)"

# let's see if there are variables exposed by netdata for system.cpu
set | grep "^NETDATA_SYSTEM_CPU_VISIBLETOTAL"

# let's see the total cpu utilization of the system
echo "${NETDATA_SYSTEM_CPU_VISIBLETOTAL}"
