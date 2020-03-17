# Portable Path Linker
This project provides a wrapper to provide a portable Windows experience. It allows a portable environment with its own `%USERNAME%` and user locations, as well as a portable way to set up its own `%PATH%` entries.

## Why though?
I typically want a portable environment on a external harddrive where my compiler and build-tools can all see each other, TexStudio can find the latex compilers, and git just works and is available everywhere within this environment. This this we can spoof environment variables before running applications, in order for the application to think the environment is different from the Windows host. 

## Best practice
* It is still best practice to use portable app versions of your programs (if available), since they usually don't tamper with the Windows registry (it's not easy to spoof the registry).
* If a portable version of an app is not available, try extracting its installer through uniextract https://github.com/Bioruebe/UniExtract2/releases to avoid the installation process.

## Nice to have's:
* I would highly suggest adding FreeCommander or Explorer++ (along with its "environment shortcut" as explained below) to your environment, in order to make it easy to explore files and have the ability to double-click on things withing this environment.
* I have added a script `drag-and-drop-here.bat` in order to drag-and-drop executables so that they will be run under this portable environment. This is usefull for installing software if all portable methods have failed.

## How to use this: 
1. Copy the content of this repo somewhere, lets call this base directory `%PORTABLEHOME%`.
2. Give yourself a username by editing `scripts/user` (stay clear from newlines or spaces).
3. Auto Generate emtpy dirs for the typical system directories (Downloads, Documents, Pictures, etc.) by running `scripts\create_user_directories (try running as admin).bat`. These system dirs will mainly be created in `user\%USERNAME%\*`. If you have symlink capabilities on the drive (admin priviliges), some usefull symlinks will be created, but don't worry otherwise.
4. You can now throw your applications in the directory `Applications/*` 
5. Add to your portable Windows %PATH% by adding lines to the file `scripts/path` (some examples are already added, remove them if you want). Note that these paths are relative to `%PORTABLEHOME%`, which currently makes it difficult to add things like `c:\blabla`, which is a good thing.
6. You can now make a shortcut-type-thing to execute any executable in `%PATH%` or in `Applications/*/*`, by copying `copy_or_symlink_me...` helpers in `scripts\` to your base `%PORTABLEHOME%` directory and renaming them to the executable you want to run. An example for running `cmd` under your portable environment is already added to this repo.
