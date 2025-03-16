# Description: Configuration file for OpenMind scripts

# Set the user that you use to login to OpenMind
export remote_user=""
if [ -z "$remote_user" ]; then
    echo "Please call install.sh with your openmind username or manually set 
        the remote_user variable in constants.sh"
    exit 1
fi
# Remote server address
export remote_login_server="openmind.mit.edu"
# Name the sbatch script for vscode
export vscode_script="vscode.sh"
# Name the sbatch script for jupyter
export jupyter_script="jupyter.sh"
# Name the sbatch vscode output file
export vscode_out="vscode.out"
# Name the sbatch jupyter output file
export jupyter_out="jupyter.out"
# Initial remote directory (for `om_ssh` command)
export remote_initial_dir="/home/$remote_user"
# Remote script directory
export remote_script_dir="/om2/user/$remote_user/slurm_scripts"
# Node wait timeout 
export timeout_limit=120
# Define port used to login to JupyterLab on local computer
export local_port=$(($RANDOM % (65535 - 49152) + 49152))
# Enter port used by JupyterLab container running on OpenMind
export remote_port=$(($RANDOM % (65535 - 49152) + 49152))
