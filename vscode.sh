#!/usr/bin/bash
#SBATCH -J vscode
#SBATCH -t 08:00:00
#SBATCH --gres=gpu:1
#SBATCH -N 1
#SBATCH -c 10
#SBATCH --mem=10G
#SBATCH -o vscode.out

sleep infinity