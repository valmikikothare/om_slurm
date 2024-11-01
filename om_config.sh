# Description: Configuration file for OpenMind scripts

# Set the directory where all scripts are located
root=$(dirname $(readlink -f $0))
cd $root
# Set the user_id
export user_id="valmiki"
# Name the sbatch script for vscode
export vscode_script="vscode.sh"
# Name the sbatch script for jupyter
export jupyter_script="jupyter.sh"
# Name the sbatch jupyter output file
export jupyter_out="jupyter.out"
# Local directory
export local_script_dir=$root
# Remote initial direcotry
export remote_initial_dir="/om2/user/$user_id"
# Remote directory
export remote_script_dir="/om2/user/$user_id/slurm_scripts"
# Node wait timeout 
export timeout_limit=120
# Define port used to login to JupyterLab on local computer
export local_port=$(($RANDOM % (65535 - 49152) + 49152))
# Enter port used by JupyterLab container running on OpenMind
export remote_port=$(($RANDOM % (65535 - 49152) + 49152))