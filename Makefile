
update: 
	sudo nix flake update
	
nixos:
	sudo nixos-rebuild switch --flake . --impure

nixos-oma:
	sudo nixos-rebuild switch --flake .# --override-input omarchy path:/home/henrysipp/Developer/omarchy-nix

macos:
	sudo darwin-rebuild switch --flake .#

gc: 
	# run garbage collection
	nix-collect-garbage --delete-older-than 5d

fmt:
	# format the nix files in this repo
	nix fmt ./
