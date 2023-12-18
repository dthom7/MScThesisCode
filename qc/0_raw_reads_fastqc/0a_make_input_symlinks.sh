#!/bin/bash

readonly source_dir=/home/jd2thomp/projects/def-bkatzenb/jd2thomp/microplastics/raw_reads/STT5Z3T/THO19922.20220315/220309_A00987_0383_BHCVTNDSX3
readonly symlink_dir=/home/jd2thomp/scratch/microplastics_v2/qc/0_raw_reads_fastqc/input

echo "Creating symlinks in directory: ${symlink_dir}"
echo "Source directory: ${source_dir}"

cd ${symlink_dir}

for fq in ${source_dir}/*.fastq.gz
do
    fq_link=$(basename ${fq})
    ln -s ${fq} ${fq_link}
    echo "Created ${fq_link} with exit status ${?}"
done

echo "Script complete"
