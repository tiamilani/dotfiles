# PathChecker

this simple python program points to checks dot files if there are changes
between the one actually used and the one in the dotfile folder for checks

you can use this program to keep updated your git dot file folder

this software is distributed as free software, you can share/modify it
but please cite the source. Thanks

the output on stdout will be the changed files

The easiest way to use the software is to just set the dot directory and append
files, but you can also manage the directory where files will be saved

Every dot file will be automatically saved in it's own directory the default
name of the directory can be setted when a path is added to the tracker.
Otherwise the program will try to figure out a name for the output directory 
from the path.
The path to the dot file directory of each file could be modified manually with
a command.

the alias of a path must be unique.

## Args

* **[-h|--help]** show an help message
* **[-d|--dot] path** setup the dot directory to use
* **[-a|--add] path [alias] [outputdir]** add a path that will be tracked, you can 
also add an alias for the path but it is optional, if not present an automatic 
alias will be assigned, you can also set the output dir name, otherwise the
output dir will be figured out by the path.
* **[-r|--remove] alias|path** you can remove a path using an alias or the entire 
path
* **[-l|--list]** print the list of actually tracked files
* **[-A|--activate] alias|path** you can activate a path that will be from now on 
tracked 
* **[-D|--deactivate]** alias|path you can deactivate a path that will be from now
on not tracked but will stay in the list of the paths
* **[-v|--verbose]** verbose output print almost everything
* **[-s|--silent]** silent output print nothing
* **[-od|--outputdir] alias|path outdir** change the output dir of path
* **[-op|--outputpath] alias|path outpath** change the output path for the dot file
remember that if an outputpath is present it will override the outputdir and 
also the dot dir, no check are performed if this path is inside the dot dir
