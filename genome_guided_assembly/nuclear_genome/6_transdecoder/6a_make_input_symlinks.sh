#!/bin/bash

readonly source_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/5_stringtie/output/fasta
readonly symlink_dir=/home/jd2thomp/scratch/microplastics_v2/genome_guided_assembly/nuclear_genome/6_transdecoder/input

echo "Creating symlinks in directory: ${symlink_dir}"
echo "Source directory: ${source_dir}"

cd ${symlink_dir}

for file in ${source_dir}/*
do
    file_link=$(basename ${file})
    ln -s ${file} ${file_link}
    echo "Created ${file_link} with exit status ${?}"
done

echo "Script complete"
