# main.nix
let
  # Import the function - here we're using a relative path
  myFunction = import ./utils/lambda.nix;

  # Call the imported function with arguments
  result = myFunction {
    arg1 = "hello";
    arg2 = "world";
  };

  macosSys = import ./utils/macosSystem.nix {
    # inherit system specialArgs;
    darwin-modules = [
      ./hosts/cerulean
    ];
    home-module = import ./home/darwin;
  };
in
  # Return the result
  result
  macosSys
