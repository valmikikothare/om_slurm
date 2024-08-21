#!/usr/bin/bash
#SBATCH -J vscode
#SBATCH -t 08:00:00
#SBATCH --gres=gpu:a100:1
#SBATCH -N 1
#SBATCH -c 8
#SBATCH --constraint=rocky8
#SBATCH --mem 10G
#SBATCH -o vscode.out

sleep infinity
