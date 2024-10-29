{ pkgs, yazi, ... }: let
	yazi-plugins = pkgs.fetchFromGitHub {
		owner = "yazi-rs";
		repo = "plugins";
		rev = "ad52adf917d6dd679dbc2dcefa3a9384654bd1c7";
		hash = "sha256-UOSH8RM+6VkQqi14bwUdFUNm8CgbDRlNial9VevjYuU=";
	};
in {
	programs.yazi = {
    package = yazi.packages.${pkgs.system}.default;
		enable = true;
		enableZshIntegration = true;
		shellWrapperName = "y";

		settings = {
			manager = {
				show_hidden = true;
			};
			preview = {
				max_width = 1000;
				max_height = 1000;
			};
		};

		plugins = {
			chmod = "${yazi-plugins}/chmod.yazi";
			full-border = "${yazi-plugins}/full-border.yazi";
			max-preview = "${yazi-plugins}/max-preview.yazi";
			starship = pkgs.fetchFromGitHub {
				owner = "Rolv-Apneseth";
				repo = "starship.yazi";
				rev = "77a65f5a367f833ad5e6687261494044006de9c3";
				sha256 = "sha256-sAB0958lLNqqwkpucRsUqLHFV/PJYoJL2lHFtfHDZF8=";
			};
		};

		initLua = ''
			require("full-border"):setup()
			require("starship"):setup()
		'';

		keymap = {
      manager.append_keymap = [
        { 
          on = "<Esc>"; 
          run = "escape";             
          desc = "Exit visual mode, clear selected, or cancel search"; 
        }
	      { 
          on = "<C-[>";
          run = "escape";   
          desc = "Exit visual mode, clear selected, or cancel search";
        }
        { 
          on = "q"; 
          run = "quit";              
          desc = "Exit the process";
        }
        { 
          on = "Q";
          run = "quit --no-cwd-file"; 
          desc = "Exit the process without writing cwd-file"; 
        }
        { 
          on = "<C-c>"; 
          run = "close";              
          desc = "Close the current tab, or quit if it is last tab";
        }
        { 
          on = "<C-z>"; 
          run = "suspend";
          desc = "Suspend the process"; 
        }

        # Hopping
        { 
          on = "<Up>";
          run = "arrow -1"; 
          desc = "Move cursor up"; 
        }
        { 
          on = "<Down>";  
          run = "arrow 1";  
          desc = "Move cursor down"; 
        }
        { 
          on = "<C-u>"; 
          run = "arrow -50%";  
          desc = "Move cursor up half page"; 
        }
        {    
          on = "<C-d>"; 
          run = "arrow 50%";   
          desc = "Move cursor down half page"; 
        }
        { 
          on = "<C-b>"; 
          run = "arrow -100%"; 
          desc = "Move cursor up one page"; 
        }
	      { 
          on = "<C-f>"; 
          run = "arrow 100%";  
          desc = "Move cursor down one page"; 
        }
        { 
          on = "<S-PageUp>";   
          run = "arrow -50%";  
          desc = "Move cursor up half page"; 
        }
        { 
          on = "<S-PageDown>"; 
          run = "arrow 50%";   
          desc = "Move cursor down half page"; 
        }
	      { 
          on = "<PageUp>";  
          run = "arrow -100%"; 
          desc = "Move cursor up one page"; 
        }
	      { 
          on = "<PageDown>"; 
          run = "arrow 100%"; 
          desc = "Move cursor down one page";
        }
	      { 
          on = [ "g" "g" ]; 
          run = "arrow -99999999";
          desc = "Move cursor to the top";
        }
        { 
          on = "G";          
          run = "arrow 99999999";  
          desc = "Move cursor to the bottom"; 
        }

        # Navigation
	      { 
          on = "<Left>"; 
          run = "leave";  
          desc = "Go back to the parent directory"; 
        }
	      { 
          on = "<Right>"; 
          run = "enter";    
          desc = "Enter the child directory"; 
        }

        # Seeking
        { 
          on = "K"; 
          run = "seek -5"; 
          desc = "Seek up 5 units in the preview"; 
        }
	      { 
          on = "J"; 
          run = "seek 5"; 
          desc = "Seek down 5 units in the preview"; 
        }

        # Selection
        { 
          on = "<Space>"; 
          run = [ "select --state=none" "arrow 1" ]; 
          desc = "Toggle the current selection state"; 
        }
	      { 
          on = "v";    
          run = "visual_mode";      
          desc = "Enter visual mode (selection mode)"; 
        }
	      { 
          on = "V";    
          run = "visual_mode --unset";  
          desc = "Enter visual mode (unset mode)"; 
        }
	      { 
          on = "<C-a>";  
          run = "select_all --state=true";    
          desc = "Select all files"; 
        }
	      { 
          on = "<C-r>"; 
          run = "select_all --state=none"; 
          desc = "Inverse selection of all files";
        }

        # Operation
        { 
          on = "<Enter>"; 
          run = "open";  
          desc = "Open selected files"; 
        }
        { 
          on = "<S-Enter>"; 
          run = "open --interactive";   
          desc = "Open selected files interactively"; 
        }
        { 
          on = "y";   
          run = "yank";  
          desc = "Yank selected files (copy)"; 
        }
        { 
          on = "x"; 
          run = "yank --cut";   
          desc = "Yank selected files (cut)"; 
        }
        { 
          on = "p";    
          run = "paste";  
          desc = "Paste yanked files"; 
        }
	      { 
          on = "P";    
          run = "paste --force";     
          desc = "Paste yanked files (overwrite if the destination exists)"; 
        }
        { 
          on = "-";     
          run = "link";   
          desc = "Symlink the absolute path of yanked files"; 
        }
	      { 
          on = "_";   
          run = "link --relative";      
          desc = "Symlink the relative path of yanked files"; 
        }
        {      
          on = "<C-->";   
          run = "hardlink";       
          desc = "Hardlink yanked files"; 
        }
        {
          on = "Y";  
          run = "unyank";     
          desc = "Cancel the yank status"; 
        }
	      {
          on = "X";
          run = "unyank";
          desc = "Cancel the yank status"; 
        }
        { 
          on = "d";     
          run = "remove";       
          desc = "Trash selected files"; 
        }
        { 
          on = "D";     
          run = "remove --permanently";
          desc = "Permanently delete selected files"; 
        }
        { 
          on = "a";    
          run = "create"; 
          desc = "Create a file (ends with / for directories)"; 
        }
	      { 
          on = "r";    
          run = "rename --cursor=before_ext"; 
          desc = "Rename selected file(s)"; 
        }
        { 
          on = ";";   
          run = "shell --interactive";   
          desc = "Run a shell command"; 
        }
        { 
          on = ":";
          run = "shell --block --interactive"; 
          desc = "Run a shell command (block until finishes)"; 
        }
        {
          on = ".";
          run = "hidden toggle";
          desc = "Toggle the visibility of hidden files"; 
        }
        { 
          on = "s";   
          run = "search fd";   
          desc = "Search files by name using fd"; 
        }
        { 
          on = "S"; 
          run = "search rg";  
          desc = "Search files by content using ripgrep"; 
        }
	      {
          on = "<C-s>"; 
          run = "escape --search"; 
          desc = "Cancel the ongoing search";
        }

        # linemode
        { 
          on = [ "m" "s" ]; 
          run = "linemode size"; 
          desc = "Set linemode to size"; 
        }
        { 
          on = [ "m" "p" ]; 
          run = "linemode permissions"; 
          desc = "Set linemode to permissions"; 
        }
	      { 
          on = [ "m" "c" ];
          run = "linemode ctime"; 
          desc = "Set linemode to ctime"; 
        }
	      { 
          on = [ "m" "m" ];
          run = "linemode mtime";      
          desc = "Set linemode to mtime";
        }
	      { 
          on = [ "m" "o" ]; 
          run = "linemode owner";   
          desc = "Set linemode to owner";
        }
        { 
          on = [ "m" "n" ];
          run = "linemode none";  
          desc = "Set linemode to none";
        }
      ];
			manager.prepend_keymap = [
        {
					on = "T";
					run = "plugin --sync max-preview";
					desc = "Maximize or restore the preview pane";
				}
				{
					on = ["c" "m"];
					run = "plugin chmod";
					desc = "Chmod on selected files";
				}
        {
          on = "z";   
          run = "plugin zoxide";  
          desc = "Jump to a directory using zoxide"; 
        }
        { 
          on = "Z";       
          run = "plugin fzf";
          desc = "Jump to a directory or reveal a file using fzf"; 
        }
			];
		};
	};
}
