#!/bin/bash

#SBATCH --time=22:00:00
#SBATCH --mem=18G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/qc/1_rcorrector/logs/1b_rcorrector.%A_%a.out
#SBATCH --cpus-per-task=8
#SBATCH --array=0-33

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables
readonly nthreads=8

#### Load modules
module load rcorrector/1.0.6

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/qc/1_rcorrector
readonly input_dir=${base_dir}/input
readonly output_dir=${base_dir}/output

#### Input
readonly R1_files=(${input_dir}/*_R1_001.fastq.gz)
readonly R2_files=(${input_dir}/*_R2_001.fastq.gz)

#### Array handling
echo "R1_files length: ${#R1_files[@]}"
echo "R2_files length: ${#R2_files[@]}"

readonly R1=${R1_files[${SLURM_ARRAY_TASK_ID}]}
readonly R2=${R2_files[${SLURM_ARRAY_TASK_ID}]}
echo "R1 file: ${R1}"
echo "R2 file: ${R2}"

#### Print version information
echo "#### PERL VERSION ####"
echo "$(perl --version)"
echo "####"
echo ""

echo "#### RCORRECTOR VERSION ####"
echo "$(run_rcorrector.pl --version)"
echo "####"
echo "NOTE: requested v1.0.6 installed. Verified independently that v1.0.6 from GitHub returns v1.0.5 with the above command"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}

run_rcorrector.pl \
    -1 ${R1} \
    -2 ${R2} \
    -od ${output_dir} \
    -t ${nthreads}

echo "Completed with exit status ${?}"
