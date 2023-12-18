#!/bin/bash

#SBATCH --time=0:10:00
#SBATCH --mem=1G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/qc/3_ribodetector/logs/3i_multiqc_rrna.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Load modules
module load python/3.10.2
source ~/python_venvs/py3.10.2_multiqc_venv/bin/activate

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/qc/3_ribodetector
readonly input_dir=${base_dir}/output/rrna/fastqc
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
