{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  buildInputs = with pkgs; [
    # Node.js 22.15.0
    nodejs_22
    alejandra
  ];

  shellHook = ''
    echo "🚀 Development environment ready!"
    echo "Node.js version: $(node --version)"
    echo "npm version: $(npm --version)"

    # Create a local node_modules if it doesn't exist
    if [ ! -d "node_modules" ]; then
      npm init -y > /dev/null 2>&1
    fi

    # Install Claude Code locally if not present
    if [ ! -d "node_modules/@anthropic-ai/claude-code" ]; then
      echo "📦 Installing Claude Code locally..."
      npm install @anthropic-ai/claude-code
    else
      echo "✅ Claude Code already installed locally"
    fi

    # Add local node_modules/.bin to PATH so we can use 'claude' directly
    export PATH="$PWD/node_modules/.bin:$PATH"

    echo "🤖 Claude Code ready! Use: claude --help"
    echo "💡 All dependencies are installed locally in this directory"
    echo ""
  '';

  # Set environment variables
  NODE_ENV = "development";
}
