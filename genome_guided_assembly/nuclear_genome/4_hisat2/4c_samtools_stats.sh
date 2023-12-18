#!/bin/bash

#SBATCH --time=4:00:00
#SBATCH --mem=8G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/4_hisat2/logs/4c_samtools_stats.%A_%a.out
#SBATCH --cpus-per-task=8
#SBATCH --array=0-33

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables
readonly nthreads=7

#### Load modules
module load samtools/1.17

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/4_hisat2
readonly input_dir=${base_dir}/output/bam
readonly output_dir=${base_dir}/output/stats

#### Array handling
readonly bams=(${input_dir}/*.bam)
echo "bams length: ${#bams[@]}"

readonly bam=${bams[${SLURM_ARRAY_TASK_ID}]}
echo "bam file: ${bam}"

#### Output
readonly stats_file=${output_dir}/$(basename ${bam}).stats

#### Print version information
echo "#### SAMTOOLS VERSION ####"
echo "$(samtools --version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}

samtools stats \
    --threads ${nthreads} \
    ${bam} \
    > ${stats_file}

echo "Completed with exit status ${?}"
