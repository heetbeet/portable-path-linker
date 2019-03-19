# Portable Path Linker
Scripts to setup a portable environment with a different %USERNAME% and user locations, as well as added entries to %PATH%. 

My typical use case is to have a portable environment where, for instance, my compiler and build-tools can all see each other, TexStudio can find the latex compilers, and git just works and is available everywhere. This is basically just a wrapper to setup the environment variables correctly before running an application. It is still best practice to use portable app versions of your programs (if available), since they usually don't tamper with the registry.

How to use this: 
1. Copy the content of this repo somewhere, lets call this base directory `%PORTABLEHOME%`.
2. Give yourself a username by editing `scripts/user` (stay clear from newlines or spaces).
3. Auto Generate emtpy dirs for the typical system Downloads, Documents, Pictures, etc. you might need in the future by running `scripts\create_user_directories (try running as admin).bat`. These system dirs will mainly be created in `user\%USERNAME%\*`. If you have symlink capabilities on the drive (and in your priviliges), some usefull symlinks will be created, but don't worry otherwise.
4. You can now throw applications in the directory `Applications/*` 
5. Add relative paths to the .exe's .bat's .dll's directories by adding lines to the file `scripts/path` (examples already added, remove them if you want). Note that this will add these paths to `%PATH%` in a portable fashion, also note that these paths are relative to `%PORTABLEHOME%`, which currently makes it difficult to add things like `c:\blabla`.
6. You can now make a "shortcut" to any executable in a `%PATH%` directory or in `Applications/*/*.*` (I implimented an file search for executables one level deeper than `Applications/`), by copying or symlinking `copy_or_symlink_me...` helpers in `scripts\` to your base `%PORTABLEHOME%` directory and renaming them to the executable you want to run. An example for running `cmd` under the portable environment is already added to this repo.
