#!/bin/bash
#
if [[ $1 == '-h' ]]; then
    echo "gitlab-project-dl.sh PRIVATE_TOKEN GITLAB_HOSTNAME GITLAB_GROUPNAME"
    exit 0
fi

set -euxo pipefail
for repo in $(curl -s --header "PRIVATE-TOKEN: $1" https://$2/api/v4/groups/$3 | jq -r ".projects[].ssh_url_to_repo");
    do git clone $repo;
done;
