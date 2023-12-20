# 23_summary_stats.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

summary_stats <- function(gene_trans_map_file,
                          transcripts_fasta_file,
                          cds_fasta_file,
                          trinotate_report_file) {
    
    gene_trans_map <- read.delim(gene_trans_map_file, header = FALSE)
    print(paste0("Number of transcripts: ", length(unique(gene_trans_map$V2))))
    print(paste0("Number of genes: ", length(unique(gene_trans_map$V1))))
    
    transcripts <- read.fasta(transcripts_fasta_file)
    transcript_lengths <- getLength(transcripts)
    print(paste0("Min transcript length: ", min(transcript_lengths)))
    print(paste0("Max transcript length: ", max(transcript_lengths)))
    print(paste0("Mean transcript length: ", mean(transcript_lengths)))
    
    cds <- read.fasta(cds_fasta_file)
    cds_lengths <- getLength(cds)
    print(paste0("Min cds length: ", min(cds_lengths)))
    print(paste0("Max cds length: ", max(cds_lengths)))
    print(paste0("Mean cds length: ", mean(cds_lengths)))
    print(paste0("Number of CDS: ", length(cds)))
    
    cds_names <- names(cds)
    cds_transcripts <- file_path_sans_ext(cds_names)
    cds_genes <- file_path_sans_ext(cds_transcripts)
    print(paste0("Number of CDS-containing genes: ", length(unique(cds_transcripts))))
    print(paste0("Number of CDS-containing genes: ", length(unique(cds_genes))))
    
    trinotate_report <- read.delim(trinotate_report_file, header = TRUE)
    
    blastp <- trinotate_report[trinotate_report$sprot_Top_BLASTP_hit != ".",
                               c("X.gene_id", "transcript_id", "prot_id", "sprot_Top_BLASTP_hit")]
    print(paste0("Swiss-Prot blastp-annotated cds: ", length(unique(blastp$prot_id))))
    print(paste0("Swiss-Prot blastp-annotated transcripts: ", length(unique(blastp$transcript_id))))
    print(paste0("Swiss-Prot blastp-annotated genes: ", length(unique(blastp$X.gene_id))))
    
    blastx <- trinotate_report[trinotate_report$sprot_Top_BLASTX_hit != ".",
                               c("X.gene_id", "transcript_id", "sprot_Top_BLASTX_hit")]
    print(paste0("Swiss-Prot blastx-annotated transcripts: ", length(unique(blastx$transcript_id))))
    print(paste0("Swiss-Prot blastx-annotated genes: ", length(unique(blastx$X.gene_id))))
    
    infernal <- trinotate_report[trinotate_report$infernal != ".",
                                 c("X.gene_id", "transcript_id", "infernal")]
    print(paste0("infernal annotated transcripts: ", length(unique(infernal$transcript_id))))
    print(paste0("infernal annotated genes: ", length(unique(infernal$X.gene_id))))
    
    pfam <- trinotate_report[trinotate_report$Pfam != ".",
                             c("X.gene_id", "transcript_id", "prot_id", "Pfam")]
    print(paste0("pfam annotated proteins: ", length(unique(pfam$prot_id))))
    print(paste0("pfam annotated transcripts: ", length(unique(pfam$transcript_id))))
    print(paste0("pfam annotated genes: ", length(unique(pfam$X.gene_id))))
    
    signalp <- trinotate_report[trinotate_report$SignalP != ".",
                                c("X.gene_id", "transcript_id", "prot_id", "SignalP")]
    print(paste0("signalp annotated proteins: ", length(unique(signalp$prot_id))))
    print(paste0("signalp annotated transcripts: ", length(unique(signalp$transcript_id))))
    print(paste0("signalp annotated genes: ", length(unique(signalp$X.gene_id))))
    
    tmhmm <- trinotate_report[trinotate_report$TmHMM != ".",
                              c("X.gene_id", "transcript_id", "prot_id", "TmHMM")]
    print(paste0("tmhmm annotated proteins: ", length(unique(tmhmm$prot_id))))
    print(paste0("tmhmm annotated transcripts: ", length(unique(tmhmm$transcript_id))))
    print(paste0("tmhmm annotated genes: ", length(unique(tmhmm$X.gene_id))))
    
    eggnog <- trinotate_report[trinotate_report$EggNM.seed_ortholog != ".",
                               c("X.gene_id", "transcript_id", "prot_id")]
    print(paste0("eggnog annotated proteins: ", length(unique(eggnog$prot_id))))
    print(paste0("eggnog annotated transcripts: ", length(unique(eggnog$transcript_id))))
    print(paste0("eggnog annotated genes: ", length(unique(eggnog$X.gene_id))))
    
    go <- trinotate_report[trinotate_report$gene_ontology_BLASTP != "." |
                               trinotate_report$gene_ontology_BLASTX != "." |
                               trinotate_report$gene_ontology_Pfam != ".",
                           c("X.gene_id", "transcript_id")]
    print(paste0("transcripts with GO: ", length(unique(go$transcript_id))))
    print(paste0("genes with GO: ", length(unique(go$X.gene_id))))
    
    ur_blastp <- trinotate_report[trinotate_report$UniRef90_BLASTP != ".",
                               c("X.gene_id", "transcript_id", "prot_id", "UniRef90_BLASTP")]
    print(paste0("UniRef90 blastp-annotated cds: ", length(unique(ur_blastp$prot_id))))
    print(paste0("UniRef90 blastp-annotated transcripts: ", length(unique(ur_blastp$transcript_id))))
    print(paste0("UniRef90 blastp-annotated genes: ", length(unique(ur_blastp$X.gene_id))))

    ur_blastx <- trinotate_report[trinotate_report$UniRef90_BLASTX != ".",
                               c("X.gene_id", "transcript_id", "UniRef90_BLASTX")]
    print(paste0("UniRef90 blastx-annotated transcripts: ", length(unique(ur_blastx$transcript_id))))
    print(paste0("UniRef90 blastx-annotated genes: ", length(unique(ur_blastx$X.gene_id))))
    
    all_annot <- trinotate_report[trinotate_report$sprot_Top_BLASTX_hit != "." |
                                      trinotate_report$infernal != "." |
                                      trinotate_report$sprot_Top_BLASTP_hit != "." |
                                      trinotate_report$Pfam != "." |
                                      trinotate_report$SignalP != "." |
                                      trinotate_report$TmHMM != "." |
                                      trinotate_report$EggNM.seed_ortholog != "." |
                                      trinotate_report$UniRef90_BLASTP != "." |
                                      trinotate_report$UniRef90_BLASTX != ".", ]
                                      
    print(paste0("proteins annotated with at least one tool: ", length(unique(all_annot$prot_id))))
    print(paste0("transcripts annotated with at least one tool: ", length(unique(all_annot$transcript_id))))
    print(paste0("genes annotated with at least one tool: ", length(unique(all_annot$X.gene_id))))
    
}