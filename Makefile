
nixos:
	sudo nixos-rebuild switch --flake .#aquamarine

nixos-debug:
	nix build ./#aquamarine

macos:
	sudo darwin-rebuild switch --flake .#cerulean

macos-personal:
	sudo darwin-rebuild switch --flake .#turquoise

macos-debug: 
	nix build ./#darwinConfigurations.cerulean.system --show-trace --verbose

gc: 
	# run garbage collection
	nix-collect-garbage --delete-older-than 5d

fmt:
	# format the nix files in this repo
	nix fmt ./
