#! /bin/bash

if [[ -f .config ]]; then
    source .config
fi

curl -sSL "http://$JENKINS_HOST/pluginManager/api/xml?depth=1&xpath=/*/*/shortName|/*/*/version&wrapper=plugins" | \
    perl -pe 's/.*?<shortName>([\w-]+).*?<version>([^<]+)()(<\/\w+>)+/\1 \2\n/g'| \
    sed 's/ /:/' | \
    sort | \
    uniq > plugins.txt
