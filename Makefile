
hypr:
	nixos-rebuild switch --flake ./#aquamarine

hypr-debug:
	nixos build .#aquamarine

macos:
	sudo darwin-rebuild switch --flake .#cerulean

macos-install:
	sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake .#cerulean

macos-debug: 
	nix build ./#darwinConfigurations.cerulean.system --show-trace --verbose

fmt:
	# format the nix files in this repo
	nix fmt ./
