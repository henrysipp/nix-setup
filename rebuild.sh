#set -e

#pushd ~/Developer/nix-setup
alejandra . &>/dev/null
git diff -U0 *.nix

# Debug: Check what commands are available
echo "Checking for rebuild commands..."
command -v nixos-rebuild && echo "Found nixos-rebuild" || echo "No nixos-rebuild"
command -v darwin-rebuild && echo "Found darwin-rebuild" || echo "No darwin-rebuild"

# Detect the system and use appropriate rebuild command
if command -v nixos-rebuild >/dev/null 2>&1; then
    echo "NixOS Rebuilding..."
    sudo nixos-rebuild switch --flake . &>nixos-switch.log || (
     cat nixos-switch.log | grep --color error && false)
    gen_info=$(sudo nixos-rebuild list-generations | grep current)
    gen_num=$(echo "$gen_info" | awk '{print $1}')
    gen="NixOS Gen $gen_num"
elif command -v darwin-rebuild >/dev/null 2>&1; then
    echo "Darwin Rebuilding..."
    darwin-rebuild switch --flake . &>darwin-switch.log || (
     cat darwin-switch.log | grep --color error && false)
    gen_info=$(darwin-rebuild --list-generations | grep current)
    gen_num=$(echo "$gen_info" | awk '{print $1}')
    gen="Darwin Gen $gen_num"
fi

# Create commit message with optional user input
if [ $# -gt 0 ]; then
    git commit -am "$gen - $*"
else
    git commit -am "$gen"
fi

#popd