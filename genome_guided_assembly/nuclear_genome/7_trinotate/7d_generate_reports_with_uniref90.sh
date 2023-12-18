#!/bin/bash

#SBATCH --time=4:00:00
#SBATCH --mem=4G
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/7_trinotate/logs/7d_generate_reports_with_uniref90.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Load modules
module load perl/5.30.2
module load sqlite/3.38.5
module load python/3.10.2
source ~/python_venvs/py3.10.2_annotation_venv/bin/activate
module load gcc/9.3.0 # required for transdecoder and blast+
module load blast+/2.14.0
module load transdecoder/5.7.1
module load hmmer/3.3.2
module load infernal/1.1.4
module load tmhmm/2.0c

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/7_trinotate
readonly output_dir=${base_dir}/output_with_uniref90
readonly working_dir=${base_dir}/working_dir

#### Other
readonly trinotate_db=${output_dir}/trinotate_db.sqlite
export TRINOTATE_HOME=/home/jd2thomp/programs/Trinotate-Trinotate-v4.0.1
export TRINOTATE_DATA_DIR=/project/6075059/jd2thomp/trinotate_data

#### Output
readonly report=${output_dir}/trinotate_report_with_uniref90.tsv
readonly gene_annotation_summary=${output_dir}/gene_annotation_summary_with_uniref90.tsv
readonly go_gene_annotation=${output_dir}/go_annotation_with_uniref90.gene.tsv
readonly go_transcript_annotation=${output_dir}/go_annotation_with_uniref90.transcript.tsv

#### Run program
echo "Beginning run"

cd ${working_dir}

${TRINOTATE_HOME}/Trinotate \
    --db ${trinotate_db} \
    --report \
    --incl_pep \
    --incl_trans \
    > ${report}

echo "Report generated with exit status ${?}"

${TRINOTATE_HOME}/util/Trinotate_get_feature_name_encoding_attributes.pl \
    ${report} \
    > ${gene_annotation_summary}

echo "Summary generated with exit status ${?}"

${TRINOTATE_HOME}/util/extract_GO_assignments_from_Trinotate_xls.pl \
    --Trinotate_xls ${report} \
    --gene \
    --include_ancestral_terms \
    > ${go_gene_annotation}

echo "GO gene annotations generated with exit status ${?}"

${TRINOTATE_HOME}/util/extract_GO_assignments_from_Trinotate_xls.pl \
    --Trinotate_xls ${report} \
    --trans \
    --include_ancestral_terms \
    > ${go_transcript_annotation}

echo "GO transcript annotations generated with exit status ${?}"
