# om_server

CLI tool to spin up OpenMind VSCode and Jupyter Slurm servers from your local machine and modify VSCode settings so you can connect to this server with the click of a button, all in one bash command.

## Installation

1. Clone the repository:
    ```bash
    git clone -b <branch_name> https://github.com/valmikikothare/om_server.git
    ```
    Replace `<branch_name>` with the appropriate branch for your operating system (e.g., `linux`, `mac`, `windows`).

2. Navigate to the cloned directory:
    ```bash
    cd om_server
    ```

3. Run the installation script:
    ```bash
    ./install.sh
    ```
    *You may need to make the script executable by running `chmod +x install.sh` before running the script.*

**Note:** If you are using a Windows machine, this package will only work with Git Bash or Windows Subsystem for Linux (WSL). For Git Bash, use the `windows` branch. For WSL, use the `linux` branch.

## Configuration

Before using the CLI tool, you need to modify the `om_config.sh` file to set up your environment variables. 
1. Open the `om_config.sh` file in a text editor:
    ```bash
    nano om_config.sh
    ```
2. Modify any variables as needed. For example, to set the `user_id` variable, you would update the line as follows:
    ```bash
    export user_id="user123"
    ```
3. Save and close the file.

**Note:**
You should only need to modify the `user_id` variable. The other variables are set to default values that should work for most users.

To override the default `sbatch` options, you can add command-line arguments to the `om_vscode` and `om_jupyter` commands (see Usage below).
You can also change the default `sbatch` options by modifying `vscode.sh` and/or `jupyter.sh` to suit your resource needs. 
1. Open the `vscode.sh` file in a text editor:
    ```bash
    nano vscode.sh
    ```
2. Modify or add any `sbatch` options as needed. For example, to request a gpu, you would add the following line:
    ```bash
    #SBATCH --gres=gpu:a100:1
    ```
3. Save and close the file.

The `jupyter.sh` file can be modified in the same way.

## Usage

To use the `om_server` CLI tool, you can run the following commands:

### Start a VSCode Server
```bash
om_vscode
```
This command will start a VSCode server on Openmind and set up the necessary configurations. To change any `sbatch` options, simply add them as arguments to the command. For example:
```bash
om_vscode --gres=gpu:1
```

### Start a Jupyter Server
```bash
om_jupyter
```
This command will start a Jupyter server on Openmind and set up the necessary configurations. `sbatch` options can be added as arguments in the same way as `om_vscode`.

**Note:**
You must have Anaconda installed and initialized on OpenMind for the default `jupyter.sh` to work. Otherwise, you must modify the `jupyter.sh` file to use a different Python environment with Jupyter Lab installed.

### Rename a Node
```bash
om_rename_node nodeXXX
```
Replace `nodeXXX` with the desired node name. This command will update the SSH configuration for the specified node.

### Cancel a Job
```bash
om_cancel [user_id] job_id
```
Replace `[user_id]` with your user ID and `job_id` with the job ID you want to cancel. If you only provide the `job_id`, it will use the default user ID from the configuration.

### SSH into Openmind
```bash
om_ssh
```
This command will start an SSH session to Openmind with the necessary configurations.
