
HOST ?= $(shell hostname)

update: 
	sudo nix flake update
	
nixos:
	sudo nixos-rebuild switch --flake .#$(HOST) --impure

nixos-oma:
	sudo nixos-rebuild switch --flake .#$(HOST) --override-input omarchy path:/home/henrysipp/Developer/omarchy-nix

macos:
	sudo darwin-rebuild switch --flake .#

gc: 
	# run garbage collection
	nix-collect-garbage --delete-older-than 5d

fmt:
	# format the nix files in this repo
	nix fmt ./
