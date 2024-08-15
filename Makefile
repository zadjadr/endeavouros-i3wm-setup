SHELL := /usr/bin/env bash

list:
	@echo "0. make endeavour-default"
	@echo "1. make packages"
	@echo "2. make work"
	@echo "3. make containerd"
	@echo "4. make k8s"
	@echo "6. make config"
	@echo "7. make theme"
	@echo "8. make zsh"
	@echo "9. make system"
	@echo "10. make name='user.name' email='user.mail' git"
	@echo "==== EXTRA ===="
	@echo "11. make background BACKGROUNDS_DIR_PATH BACKGROUND_FULL_NAME"
	@echo "12. make fstab (make sure to change this according to your needs)"
	@echo "13. make acpid DISPLAY_NAME AUTORANDR_SETTING (its best to do this manually in the script)"
	@echo "14. make nvidia"

acpid:
	./custom-scripts/install-acpid-events.sh $(display_name) $(autorandr_setting)

background:
	./custom-scripts/set-backgrounds.sh $(backgrounds_path) $(background)

config:
	./custom-scripts/install-configs.sh

git:
	./custom-scripts/git-config.sh $(name) $(email)

containerd:
	./custom-scripts/install-containerd.sh

endeavour-default:
	./i3_install

theme:
	./custom-scripts/install-fonts.sh
	./custom-scripts/install-cursor.sh
	killall picom

fstab:
	./custom-scripts/only-for-me/set-fstab.sh
	./custom-scripts/only-for-me/auto-unmount.sh

k8s:
	./custom-scripts/install-k8s.sh

nvidia:
	sudo pacman -Sy --needed --noconfirm nvidia-inst
	nvidia-inst

packages:
	./custom-scripts/install-packages.sh
	./custom-scripts/install-external-packages.sh

system:
	./custom-scripts/system.sh
	./custom-scripts/install-mirrorlist-updater.sh

work:
	./custom-scripts/work/install-packages.sh
	./custom-scripts/work/stop-onedrive.sh

zsh:
	./custom-scripts/install-zsh.sh
