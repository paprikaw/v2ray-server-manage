# Dependency of the shell script switch-vps.sh
# 
import json
import os
import sys

filename = os.environ['V2RAY_CLIENT_CONFIG_LOC']

with open(filename, 'r') as f:
    data = json.load(f)
    data["outbounds"][0]["settings"]['vnext'][0]['address'] = sys.argv[1]
    data["outbounds"][0]["streamSettings"]['tlsSettings']['serverName'] = sys.argv[2]
os.remove(filename)
with open(filename, 'w+') as f:
    json.dump(data, f, indent=4)