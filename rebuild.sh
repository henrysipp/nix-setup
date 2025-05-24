#set -e
#pushd ~/Developer/nix-setup

git add -A
alejandra . &>/dev/null
git diff -U0 *.nix

# Debug: Check what commands are available
echo "Checking for rebuild commands..."
command -v nixos-rebuild && echo "Found nixos-rebuild" || echo "No nixos-rebuild"
command -v darwin-rebuild && echo "Found darwin-rebuild" || echo "No darwin-rebuild"

# Initialize variables
rebuild_success=false
gen=""

# Detect the system and use appropriate rebuild command
if command -v nixos-rebuild >/dev/null 2>&1; then
    echo "NixOS Rebuilding..."
    if sudo nixos-rebuild switch --flake . &>nixos-switch.log; then
        gen_info=$(sudo nixos-rebuild list-generations | grep current)
        gen_num=$(echo "$gen_info" | awk '{print $1}')
        gen="NixOS Gen $gen_num"
        rebuild_success=true
    else
        echo "NixOS rebuild failed:"
        cat nixos-switch.log # | grep --color error
        exit 1
    fi
elif command -v darwin-rebuild >/dev/null 2>&1; then
    echo "Darwin Rebuilding..."
    if darwin-rebuild switch --flake . &>darwin-switch.log; then
        gen_info=$(darwin-rebuild --list-generations | grep current)
        gen_num=$(echo "$gen_info" | awk '{print $1}')
        gen="Darwin Gen $gen_num"
        rebuild_success=true
    else
        echo "Darwin rebuild failed:"
        cat darwin-switch.log | grep --color error
        exit 1
    fi
fi

# Only commit if rebuild was successful
if [ "$rebuild_success" = true ]; then
    # Create commit message with optional user input
    if [ $# -gt 0 ]; then
        git commit -am "$gen - $*"
    else
        git commit -am "$gen"
    fi
    echo "Successfully rebuilt and committed: $gen"
else
    echo "No rebuild command found or rebuild failed. Not committing to git."
    exit 1
fi

#popd