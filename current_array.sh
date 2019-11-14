#!/bin/bash
#SBATCH -J current # A single job name for the array
#SBATCH -p serial_requeue # 
#SBATCH -c 1 # one core
#SBATCH -N 1 # on one node
#SBATCH -t 2-10:00 # Running time of 10 hours
#SBATCH --mem 128000 # Memory request of 128 GB
#SBATCH -o current_%A_%a.out # Standard output
#SBATCH -e current_%A_%a.err # Standard error
#SBATCH --mail-type=ALL
#SBATCH --mail-user=jfrtonini@gmail.com
#SBATCH --account=pierce_lab
#SBATCH --array=0-914

module load gcc/7.1.0-fasrc01 R/3.5.1-fasrc02 R_core/3.5.1-fasrc02 R_packages/3.5.1-fasrc02
module load gdal/2.3.0-fasrc01 proj/5.0.1-fasrc01 geos/3.6.2-fasrc01

export R_LIBS_USER=$HOME/apps/R_3.5.1:$R_LIBS_USER

FILES=($(ls -1 *.csv))

FILENAME=${FILES[$SLURM_ARRAY_TASK_ID]}

Rscript ENM_current_wc_birds_v2.R $FILENAME
