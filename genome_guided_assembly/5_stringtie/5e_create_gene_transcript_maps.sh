#!/bin/bash

#SBATCH --time=8:00:00
#SBATCH --mem=128M
#SBATCH --output=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/5_stringtie/logs/5e_create_gene_transcript_maps.%j.log

#### Set bash flags
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace # Uncomment for debugging

#### Directories
readonly base_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/5_stringtie
readonly output_dir=${base_dir}/output/fasta

#### Input
readonly input_fa=${output_dir}/merged.wf_nuc_align.fa

#### Output
readonly output_g2t_tsv=${output_dir}/merged.wf_nuc_align.gene_transcript_map.tsv
readonly output_t2g_tsv=${output_dir}/merged.wf_nuc_align.transcript_gene_map.tsv

#### Run program
echo "Beginning run"

cd ${base_dir}

grep ">" ${input_fa} | while read -r transcript
do
    t=${transcript:1}
    g=${t%.*}

    #g2t
    printf "${g}\t" >> ${output_g2t_tsv}
    echo "${t}" >> ${output_g2t_tsv}

    #t2g
    printf "${t}\t" >> ${output_t2g_tsv}
    echo "${g}" >> ${output_t2g_tsv}
done

echo "Completed with exit status ${?}"
