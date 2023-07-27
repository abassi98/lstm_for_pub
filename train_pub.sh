#!/bin/bash
#SBATCH --job-name=pub_lstm
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=3
#SBATCH --time=24:00:00
#SBATCH --partition=earth-4
#SBATCH --constraint=rhel8
#SBATCH --gres=gpu:a100:1
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=END,FAIL     
#SBATCH --output=pub_lstm.out
#SBATCH --error=pub_lstm.err
nsplits=12
nseeds=10
firstseed=300
gpu=0


for (( seed = $firstseed ; seed < $((nseeds+$firstseed)) ; seed++ )); do

  python3 main.py --n_splits=$nsplits --seed=$seed create_splits 
  wait

  for ((split = 0 ; split < $nsplits ; split++ )); do  
    
    echo $seed $gpu

    if [ "$1" = "lstm" ]
    then

      outfile="reports/pub_lstm_nostat_extended_nldas.$seed.$split.out"
      python3 main.py --gpu=$gpu --no_static=True --split=$split --split_file="data/kfold_splits_seed$seed.p" train > $outfile &

    else
      echo bad model choice
      exit
    fi

    if [ $gpu -eq 2 ]
    then
      wait
    fi

  done
done

