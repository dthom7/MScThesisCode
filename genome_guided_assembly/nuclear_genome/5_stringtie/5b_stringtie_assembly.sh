#!/bin/bash

#SBATCH --time=1:00:00
#SBATCH --mem=2G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/5_stringtie/logs/5b_stringtie_assembly.%A_%a.out
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
module load stringtie/2.2.1

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/5_stringtie
readonly input_dir=${base_dir}/input
readonly output_dir=${base_dir}/output/per_sample_gtfs

#### Array handling
readonly bams=(${input_dir}/*.bam)
echo "bams length: ${#bams[@]}"

readonly bam=${bams[${SLURM_ARRAY_TASK_ID}]}
readonly sample_id=$(basename ${bam} .bam)
echo "bam file: ${bam}"
echo "sample id: ${sample_id}"

#### Output
readonly output_file=${output_dir}/${sample_id}.gtf

#### Print version information
echo "#### VERSION ####"
echo "$(stringtie --version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}

stringtie \
    --rf \
    -p ${nthreads} \
    -o ${output_file} \
    ${bam}

echo "Completed with exit status ${?}"
