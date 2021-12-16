#!/bin/bash
echo
echo "Based on https://github.com/cli/cli/blob/trunk/docs/install_linux.md guide"
echo
sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
sudo dnf -y install gh
gh auth login
