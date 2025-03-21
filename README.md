# om_server

CLI tool to spin up OpenMind VSCode and Jupyter Slurm servers from your local
machine and modify VSCode settings so you can connect to this server with the
click of a button, all in one bash command.

Inspired by https://github.mit.edu/prevosto/remote_notebook_scripts, which
provides the same Jupyter Notebook functionality as well as a working example
using [Singularity](https://docs.sylabs.io/guides/latest/user-guide/) to run
the [CaImAn](https://github.com/flatironinstitute/CaImAn) toolbox.

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/valmikikothare/om_server.git
    ```

2. Navigate to the cloned directory:
    ```bash
    cd om_server
    ```

3. Run the installation script:
    ```bash
    ./install.sh <your-openmind-username>
    ```
    *You may need to make the script executable by running `chmod +x install.sh`
    before running the script.*

**Note:** If you are using a Windows machine, this package will only work with
Git Bash or Windows Subsystem for Linux (WSL). If using git bash, you will
first need to [enable developer mode](https://learn.microsoft.com/en-us/windows/apps/get-started/enable-your-device-for-development)
in windows.

## Configuration

You may want to configure some of the variables used by the package to interact
with OpenMind and Slurm. To do so:
1. Open the `constants.sh` file in your preferred text editor:
    ```bash
    nano constants.sh
    ```
2. Modify any variables as needed. For example, to set the `remote_user` 
variable, you would update the line as follows:
    ```bash
    export remote_user="user123"
    ```
3. Save and close the file.

**Note:**
You should only need to modify the `remote_user` variable. The other variables are set to default values that should work for most users.

To override the default `sbatch` options, you can add command-line arguments to
the `om_vscode` and `om_jupyter` commands (see Usage below).
You can also change the default `sbatch` options by modifying `vscode.sh`
and/or `jupyter.sh` to suit your resource needs. 
1. Open the `vscode.sh` file in a text editor:
    ```bash
    nano vscode.sh
    ```
2. Modify or add any `sbatch` options as needed. For example, to request a gpu,
   you would add the following line:
    ```bash
    #SBATCH --gres=gpu:a100:1
    ```
3. Save and close the file.

The `jupyter.sh` file can be modified in the same way.

## Usage

To use the `om_vscode` and `om_jupyter` CLI tools, you can run the following
commands:

### Start a VSCode Server
```bash
om_vscode
```
This command will start a VSCode server on Openmind and set up the necessary
configurations. To change any `sbatch` options, simply add them as arguments to
the command. For example:
```bash
om_vscode --gres=gpu:1
```

### Start a Jupyter Server
```bash
om_jupyter
```
This command will start a Jupyter server on Openmind and set up the necessary
configurations. `sbatch` options can be added as arguments in the same way as
`om_vscode`.

**Note:**
You must have Anaconda installed and initialized on OpenMind for the default
`jupyter.sh` to work. Otherwise, you must modify the `jupyter.sh` file to use a
different Python environment with Jupyter Lab installed.

### Rename a Node
```bash
om_rename_node <nodeXXX>
```
Replace `<nodeXXX>` with the desired node name. This command will update the SSH configuration for the specified node.

### Cancel a Job
```bash
om_cancel [--all] <job_id>
```
Replace `<job_id>` with the job ID you want to cancel. If you provide the `--all` flag, all jobs for the remote user will be cancelled.

### SSH into Openmind
```bash
om_ssh
```
This command will start an SSH session to Openmind with the necessary
configurations.

### List Jobs
```bash
om_queue
```
This command will list all jobs for the user.

## Troubleshooting

Most commands will print a message to the terminal if they fail. 

If `om_vscode` or `om_jupyter` succeeds, but you are unable to connect to the server, try the following:

1. Check if the node is running with the `om_queue` command. 
    1. If the node is not shown in the queue, the job may have been preempted or terminated.
        - To check if it was a preemption, re-run `om_vscode` or `om_jupyter` to create a new node, then try connecting again.
        - If this does not resolve the issue, check your `vscode.sh` or `jupyter.sh` files ensure that you have not made any modifications that might have caused the initialization to fail. To check the output of your job, try the following:
            ```bash
            om_ssh
            cat <remote_script_dir>/vscode.out
            ```
            or
            ```bash
            om_ssh
            cat <remote_script_dir>/jupyter.out
            ```
            where `<remote_script_dir>` is defined in `constants.sh`.

            If you see any error messages, try to resolve them by modifying your `vscode.sh` or `jupyter.sh` files.
    2. If the node is shown in the queue, but you are unable to connect to the server, it may be an authentication issue. Try deleting the known hosts file as follows:
        ```bash
        rm ~/.ssh/known_hosts
        ```
        and try connecting again. 

If you are still experiencing issues, please submit an issue on the [GitHub repository](https://github.com/valmikikothare/om_server/issues).



