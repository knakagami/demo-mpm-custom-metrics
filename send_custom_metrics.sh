#!/bin/bash

REALM=jp0                           # Splunk-JP-Sandbox
API_TOKEN="ovT21OrEwFBLZqel3m4w1w"    # o11y-demo-jp0-api

DIR=/home/splunker/demo-mpm/
METRIC_LIST=${DIR}/metric_name.lst
DIMENSION_LIST=${DIR}/dimension_name.lst

TEMP_JSON=$(mktemp /tmp/custom_metrics_$(date +%Y%m%d-%H%M%S)_XXX)

# Set 
cat ${METRIC_LIST} |\
while read metric_list; do
    cat ${DIMENSION_LIST} |\
    while read dimension_list; do
#        echo "'{\"gauge\": [{\"metric\": \"${metric_list}\", \"value\": ${RANDOM}, \"dimensions\": \"{${dimension_list}}\"}]}'," | tee -a ${TEMP_JSON}
        echo "{\"metric\": \"${metric_list}\", \"value\": ${RANDOM}, \"dimensions\": {${dimension_list}}}" | tee -a ${TEMP_JSON}
    done
done

# adjust json
#sed -i '$s/,$//' ${TEMP_JSON}

# Send metrics

cat ${TEMP_JSON} | \
    while read line; do
        curl \
            --request POST \
            --header "Content-Type: application/json" \
            --header "X-SF-TOKEN: ${API_TOKEN}" \
            --data "{\"gauge\": [${line}]}" \
            https://ingest.${REALM}.signalfx.com/v2/datapoint
        echo $?
    done