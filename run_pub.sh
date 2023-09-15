#!/bin/bash
#SBATCH --job-name=pub_lstm
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=6
#SBATCH --time=12:00:00
#SBATCH --partition=earth-1
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END,FAIL     
#SBATCH --output=pub_lstm.out
#SBATCH --error=pub_lstm.err

module load gcc/9.4.0-pe5.34 miniconda3/4.12.0 lsfm-init-miniconda/1.0.0	# comment to run on your machine


# the above code is meant to run on ZAHW cluster in Zurich. Modify it to use in your machine/cluster. 
# from here onwards you can run everywhere

conda activate hydro # comment to run on your machine

#python run_pub.py $1 $2 # $1=experiment $2=gpu
python analysis/main_performance.py $1