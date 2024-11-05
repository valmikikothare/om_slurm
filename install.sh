root=$(dirname $(readlink -f $0))

for file in om_jupyter om_cancel om_rename_node om_ssh om_vscode; do
    chmod +x "$root/$file"
    sudo ln -sf "$root/$file" "/usr/local/bin/$file"
done