#!/usr/bin/env bash

set -e 

script_dir=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

print_usage() {
    echo "Usage: install.sh [remote_user] [Options]"
    echo "Options:"
    echo "  -h, --help: Print this help message"
    echo "  -u, --remote-user <remote user>: Set the remote user"
    echo "You can provide the remote user as a positional argument or"\
         "use the -u/--remote-user option to set the remote user."
}

set_twice=false
while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
        print_usage
        exit 0
        ;;
    -u|--remote-user)
        # Check if a remote user is already specified
        if [[ -n "$remote_user" ]]; then
            set_twice=true
        fi
        # Check if a remote user is provided
        if [[ -n "$2" ]]; then
            remote_user="$2"
            shift # past argument
            shift # past value
        else
            echo "Error: --remote-user requires a value."
            exit 1
        fi
        ;;
    -*)
        echo "Error: Unknown argument passed: $1"
        exit 1
        ;;
    *)
        # Check if a remote user is already specified
        if [[ -n "$remote_user" ]]; then
            set_twice=true
        fi
        remote_user="$1"
        shift
        ;;
  esac
done

if [[ -z "$remote_user" ]]; then
    echo "Error: Remote user not specified"
    print_usage
    exit 1
fi

if $set_twice; then
    echo "Error: Cannot provide remote user more than once"
    exit 1
fi

# Update the remote user in the constants.sh file
echo "Updating remote user in constants.sh to $remote_user"

# Platform-agnostic approach using awk to update the config file
awk -v user="$remote_user" '
    /^export remote_user=/ {print "export remote_user=\"" user "\""; next}
    {print}
' "$script_dir/constants.sh" > "$script_dir/constants.sh.tmp" && 
mv "$script_dir/constants.sh.tmp" "$script_dir/constants.sh"

echo "Installing om_server scripts to $HOME/.local/bin"

for file in om_jupyter om_cancel om_rename_node om_ssh om_vscode om_queue; do
    chmod +x "$script_dir/$file"
done

# Create the .local/bin directory if it doesn't exist
mkdir -p $HOME/.local/bin

# Allow symbolic links in git bash
MSYS=winsymlinks:nativestrict

# Create symlinks to the om_server scripts in the .local/bin directory
ln -sf $script_dir/om_jupyter $HOME/.local/bin/om_jupyter
ln -sf $script_dir/om_vscode $HOME/.local/bin/om_vscode
ln -sf $script_dir/om_rename_node $HOME/.local/bin/om_rename_node
ln -sf $script_dir/om_ssh $HOME/.local/bin/om_ssh
ln -sf $script_dir/om_cancel $HOME/.local/bin/om_cancel
ln -sf $script_dir/om_queue $HOME/.local/bin/om_queue

# Add the .local/bin directory to the PATH
# Check if $HOME/.local/bin is already in the PATH
if ! grep -q "export PATH=.*$HOME/.local/bin" ~/.bashrc; then
    echo "Adding $HOME/.local/bin to the PATH"
    echo "export PATH=\"$HOME/.local/bin:\$PATH\"" >> ~/.bashrc
fi

echo "Installation complete. You can now use the om_jupyter, om_vscode,"\
     "om_rename_node, om_ssh, om_cancel, and om_queue commands."
