#!/bin/bash

# Script to check if external DNS servers are pingable, if not assume we have
# an internet outage and send alert to ntfy.22hol.co.uk (internal)

wget -q --tries=20 --timeout=10 http://www.google.com -O /tmp/google.idx &> /dev/null
if [ ! -s /tmp/google.idx ]
then
  echo "Possible internet outage, sending alert"
  curl -H "Title: Possible internet access outage" \
     -H "Priority: max" \
     -H "Tags: warning" \
     -d "Potential WAN outage detected. Please check." \
     "http://ntfy.22hol.co.uk/Network_Alerts?auth=QmFzaWMgZFc1eVlXbGtPblZ1VWtGcFpERXdNamtx"
else
  echo "All seems good"
fi

