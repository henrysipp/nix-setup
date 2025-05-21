{
  userfullname,
  useremail,
  ...
}: {
  programs.git = {
    enable = true;
    userName = userfullname;
    userEmail = useremail;
  };

  programs.lazygit = {
    enable = true;
  };
}
