#!/usr/bin/env bash

# Variables definition

export SCALE_UP_AT=40
export SCALE_DOWN_AT=20

export SCALE_STEP=1

export MIN_SIZE=1
export MAX_SIZE=4

# Script safety check
if [ "$#" -ne 1 ]; then
  echo "Please provide the Loadbalancer DNS as an argument"
  echo "  > Usage ./monitor-cpu-usage.sh <Loadbalancer-public-dns>"
  exit 1
fi

# Netdata monitoring
eval "$(curl -s $1:19999/api/v1/allmetrics)"
set | grep "^NETDATA_SYSTEM_CPU_VISIBLETOTAL"

scale_up() {
    echo "Scaling up the autoscaling group..."
    echo "Checking number of running instances..."
    INSTANCES=$(terragrunt output alb_instances 2> /dev/null)
    INSTANCE_COUNT=$(echo $(echo "${INSTANCES}" | wc -l))

    if [ "${INSTANCE_COUNT}" -lt "${MAX_SIZE}" ]; then
        echo "Adjusting the size of the autoscaling group instances (+ ${SCALE_STEP})..."

        DESIRED_COUNT=$(( ${INSTANCE_COUNT} + ${SCALE_STEP} ))
        terragrunt apply  -var app_count="${DESIRED_COUNT}" -auto-approve 2> /dev/null
    else
        echo "The autoscaling group has reached the maximum size ${MAX_SIZE}/${INSTANCE_COUNT}..."
    fi
}

scale_down() {
    echo "Checking number of running instances..."
    INSTANCES=$(terragrunt output alb_instances 2> /dev/null)
    INSTANCE_COUNT=$(echo $(echo "${INSTANCES}" | wc -l))

    if [ "${INSTANCE_COUNT}" -gt "${MIN_SIZE}" ]; then
        echo "Adjusting the size of the autoscaling group instances (- ${SCALE_STEP})..."

        DESIRED_COUNT=$(( ${INSTANCE_COUNT} - ${SCALE_STEP} ))
        terragrunt apply  -var app_count="${DESIRED_COUNT}" -auto-approve 2> /dev/null
    else
        echo "The autoscaling group has reached the minmum size ${INSTANCE_COUNT}/${MIN_SIZE}..."
    fi
}

autoscaler() {
    echo "The CPU load is ${NETDATA_SYSTEM_CPU_VISIBLETOTAL}%"

    if [ "${NETDATA_SYSTEM_CPU_VISIBLETOTAL}" -gt "${SCALE_UP_AT}" ]; then
        echo "The autoscaling group is scaling up..."
        scale_up
    else
        if [ "${NETDATA_SYSTEM_CPU_VISIBLETOTAL}" -lt "${SCALE_DOWN_AT}" ]; then
            echo "The autoscaling group is scaling down..."
            scale_down
        else
            echo "The autoscaling does not need adjustments !"
        fi
    fi
}

# Main
autoscaler
