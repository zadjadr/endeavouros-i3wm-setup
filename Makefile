SHELL := /usr/bin/env bash

list:
	@echo "0. make endeavour-default"
	@echo "1. make packages"
	@echo "2. make work"
	@echo "3. make k8s"
	@echo "4. make docker"
	@echo "5. make albert"
	@echo "7. make config 'user.name' 'user.mail'"
	@echo "8. make fonts"
	@echo "9. make zsh"
	@echo "10. make system"
	@echo "==== EXTRA ===="
	@echo "11. make background BACKGROUNDS_DIR_PATH BACKGROUND_FULL_NAME"
	@echo "12. make fstab (make sure to change this according to your needs)"
	@echo "13. make acpid DISPLAY_NAME AUTORANDR_SETTING (its best to do this manually in the script)"
	@echo "14. make nvidia"

acpid:
	./custom-scripts/install-acpid-events.sh $(display_name) $(autorandr_setting)

albert:
	./custom-scripts/install-albert.sh

background:
	./custom-scripts/set-backgrounds.sh $(backgrounds_path) $(background)

config:
	./custom-scripts/install-configs.sh
	./custom-scripts/install-mirrorlist-updater.sh
	./custom-scripts/git-config.sh $(name) $(email)

docker:
	./custom-scripts/install-docker.sh

endeavour-default:
	./i3_install

fonts:
	./custom-scripts/install-fonts.sh
	./custom-scripts/fix-icons.sh

fstab:
	./custom-scripts/only-for-me/set-fstab.sh

k8s:
	./custom-scripts/install-k8s.sh

nvidia:
	nvidia-inst

packages:
	./custom-scripts/install-packages.sh
	./custom-scripts/install-external-packages.sh
	./custom-scripts/install-timeshift.sh
	./custom-scripts/install-firewall.sh

system:
	./custom-scripts/system.sh

work:
	./custom-scripts/work/install-packages.sh

zsh:
	./custom-scripts/install-zsh.sh