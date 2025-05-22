{...}: {
	imports = [];
	services = {
		gvfs.enable = true; #Mount, trash, and other functionalities
		tumbler.enable = true; #Thumbnail support
	};

	programs = {
		hyprland = {
			enable = true;
		};
	};

	environment.systemPackages = with pkgs; [
		waybar
		swaybg
		swayidle
		swaylock
		wlogout
		wl-clipboard

		alsa-utils
		mpd
		mpc-cli
		ncmpcpp
		networkmanagerapplet
	];
}