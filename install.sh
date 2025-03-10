#!/usr/bin/env bash

script_dir=$(dirname $(readlink -f ${BASH_SOURCE[0]}))


echo "Installing om_server scripts to $HOME/.local/bin"

for file in om_jupyter om_cancel om_rename_node om_ssh om_vscode om_queue; do
    chmod +x "$script_dir/$file"
done

# Create the .local/bin directory if it doesn't exist
mkdir -p $HOME/.local/bin

# Create symlinks to the om_server scripts in the .local/bin directory
ln -sf $script_dir/om_jupyter $HOME/.local/bin/om_jupyter
ln -sf $script_dir/om_vscode $HOME/.local/bin/om_vscode
ln -sf $script_dir/om_rename_node $HOME/.local/bin/om_rename_node
ln -sf $script_dir/om_ssh $HOME/.local/bin/om_ssh
ln -sf $script_dir/om_cancel $HOME/.local/bin/om_cancel
ln -sf $script_dir/om_queue $HOME/.local/bin/om_queue

# Add the .local/bin directory to the PATH
# Check if $HOME/.local/bin is already in the PATH
if ! echo $PATH | grep -q "$HOME/.local/bin"; then
    echo "Adding $HOME/.local/bin to the PATH"
    echo "export PATH=\"$HOME/.local/bin:\$PATH\"" >> ~/.bashrc
fi

echo "Installation complete. You can now use the om_jupyter, om_vscode,"\
     "om_rename_node, om_ssh, om_cancel, and om_queue commands."
