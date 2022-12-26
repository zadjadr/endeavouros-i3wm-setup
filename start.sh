#!/bin/bash

./custom-scripts/install-packages.sh
./custom-scripts/install-external-packages.sh
./custom-scripts/install-aur-packages.sh
./custom-scripts/install-docker.sh
./custom-scripts/install-configs.sh
./custom-scripts/install-fonts.sh
./custom-scripts/install-acpid-events.sh
./custom-scripts/git-config.sh

./custom-scripts/install-zsh.sh 