My .dotfiles
============

Each [branch](https://github.com/adrianp/dotfiles/branches) corresponds to the
files used on a specific machine. For example, you won't find the
*.bash_aliases* file on master, as these are specific to each installation
(look in the branches for some examples).

The [deploy.sh](https://github.com/adrianp/dotfiles/blob/master/deploy.sh)
script can be used to, well, deploy the dotfiles :-). Notice that we are simply
linking the dotfiles in the repository from their actual locations in the
filesystem (usually */home/*), so we can easily update them both locally and
remotely ([the Git repository](https://github.com/adrianp/dotfiles)).