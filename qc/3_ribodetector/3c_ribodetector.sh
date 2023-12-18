#!/bin/bash

#SBATCH --time=8:00:00
#SBATCH --mem=32G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/qc/3_ribodetector/logs/3c_ribodetector.%A_%a.out
#SBATCH --cpus-per-task=20
#SBATCH --threads-per-core=1
#SBATCH --array=0-33

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables
readonly nthreads=20

#### Load modules
module load python/3.9.6
source ~/python_venvs/py3.9.6_ribodetector_env/bin/activate

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/qc/3_ribodetector
readonly input_dir=${base_dir}/input
readonly output_dir=${base_dir}/output

#### Input
readonly R1_files=(${input_dir}/*.cor.trim.R1.fq.gz)
readonly R2_files=(${input_dir}/*.cor.trim.R2.fq.gz)

#### Array handling
echo "R1_files length: ${#R1_files[@]}"
echo "R2_files length: ${#R2_files[@]}"

readonly R1=${R1_files[${SLURM_ARRAY_TASK_ID}]}
readonly R2=${R2_files[${SLURM_ARRAY_TASK_ID}]}
readonly sample_id=$(basename ${R1} .cor.trim.R1.fq.gz)
echo "R1 file: ${R1}"
echo "R2 file: ${R2}"
echo "sample id: ${sample_id}"

#### Output
readonly R1_rem_out=${output_dir}/rrna_removed/${sample_id}.cor.trim.nonrrna.R1.fq.gz
readonly R2_rem_out=${output_dir}/rrna_removed/${sample_id}.cor.trim.nonrrna.R2.fq.gz
readonly R1_rrna_out=${output_dir}/rrna/${sample_id}.cor.trim.rrna.R1.fq.gz
readonly R2_rrna_out=${output_dir}/rrna/${sample_id}.cor.trim.rrna.R2.fq.gz

#### Print version information
echo "#### VERSION ####"
echo "$(ribodetector_cpu --version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}

ribodetector_cpu \
    -i ${R1} ${R2} \
    -o ${R1_rem_out} ${R2_rem_out} \
    -r ${R1_rrna_out} ${R2_rrna_out} \
    -e rrna \
    -t ${nthreads} \
    -l 148 \
    --chunk_size 1000

echo "Completed with exit status ${?}"
