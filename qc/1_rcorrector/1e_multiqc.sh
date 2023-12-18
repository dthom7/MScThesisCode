#!/bin/bash

#SBATCH --time=1:00:00
#SBATCH --mem=2G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/qc/1_rcorrector/logs/1e_multiqc.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Set cpu/mem variables

#### Load modules
module load python/3.10.2
source ~/python_venvs/py3.10.2_multiqc_venv/bin/activate

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/qc/1_rcorrector
readonly input_dir=${base_dir}/output/unfixable_removed/fastqc
readonly output_dir=${input_dir}/multiqc

#### Print version information
echo "#### VERSION ####"
echo "$(multiqc --version)"
echo "####"
echo ""

#### Run program
echo "Beginning run"

cd ${base_dir}

multiqc \
    -o ${output_dir} \
    ${input_dir}

echo "Completed with exit status ${?}"
