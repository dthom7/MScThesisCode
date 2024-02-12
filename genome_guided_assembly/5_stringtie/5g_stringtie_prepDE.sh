#!/bin/bash

#SBATCH --time=01:00:00
#SBATCH --mem=2G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/5_stringtie/logs/5g_stringtie_prepDE.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Load modules
module load python/3.10.2
module load stringtie/2.2.1

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/5_stringtie
readonly input_dir=${base_dir}/output/coverage_tables
readonly output_dir=${base_dir}/output/count_tables

#### Print version information
echo "#### STRINGTIE VERSION ####"
echo "$(stringtie --version)"
echo "####"
echo ""

echo "#### PYTHON VERSION ####"
echo "$(python3 --version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${output_dir}

prepDE.py3 \
    -i ${input_dir} \
    -l 148

echo "Completed with exit status ${?}"
