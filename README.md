# demo-mpm-custom-metrics
send custom metrics based on the list of metric names and dimension names with each random (from 0 to 32767) number.

# Usage
1. set the realm and ingest access token in the `env` file
2. edit `metric_name.lst` and `dimension_name.lst`
    - metric_name.lst: add metric names you like in each line
    - dimension_name.lst: add `"key": "value` sets. possible to set some dimensions every line.
3. exec the send_custom_metrics.sh
    - loop exec bash script if you need to keep ingesting the metrics
