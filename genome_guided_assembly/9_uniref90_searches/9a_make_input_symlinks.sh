#!/bin/bash

readonly transcripts=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/5_stringtie/output/fasta/merged.wf_nuc_align.fa
readonly peps=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/6_transdecoder/output/merged.wf_nuc_align.fa.transdecoder.pep
readonly symlink_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/9_uniref90_searches/input
readonly in_files=( ${transcripts} ${peps} )

echo "Creating symlinks in directory: ${symlink_dir}"

cd ${symlink_dir}

for file in "${in_files[@]}"
do
    file_link=$(basename ${file})
    ln -s ${file} ${file_link}
    echo "Created ${file_link} with exit status ${?}"
done

echo "Script complete"
