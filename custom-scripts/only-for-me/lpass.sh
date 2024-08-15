#!/bin/bash
#
# Load environment variables from pass
# Is linked to /usr/local/bin/lpass
for env in $( (pass bitwarden.io.ki/api ) | grep -v '^#' | grep -v '^$'); do
  export "${env?}"
done
