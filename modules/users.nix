{ ... }: 

{
  users.users.mathias = {
    isNormalUser = true;
    home = "/home/mathias";
    description = "Mathias";
    extraGroups = [
      "wheel" 
      "video" 
      "input"
    ];
  };
}
