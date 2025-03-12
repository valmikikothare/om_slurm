# Description: Configuration file for OpenMind scripts

# Set the user that you use to login to OpenMind
export remote_user=""
if [ -z "$remote_user" ]; then
    echo "Please set the remote_user variable in om_config.sh"
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
# Remote initial direcotry
export remote_initial_dir="/om2/user/$remote_user"
# Remote directory
export remote_script_dir="/om2/user/$remote_user/slurm_scripts"
# Node wait timeout 
export timeout_limit=120
# Define port used to login to JupyterLab on local computer
export local_port=$(($RANDOM % (65535 - 49152) + 49152))
# Enter port used by JupyterLab container running on OpenMind
export remote_port=$(($RANDOM % (65535 - 49152) + 49152))
