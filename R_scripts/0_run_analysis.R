# 0_run_analysis.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

options(warn = 1)
log_file <- file(paste0("output/",
                        format(Sys.time(), "%Y-%m-%d_%H-%M-%S"),
                        "_0_run_analysis_console.log"),
                 open = "wt")
sink(file = log_file, type = "output")
sink(file = log_file, type = "message")

#### Libraries
library(tidyverse)
library(DESeq2)
library(clusterProfiler)
library(KEGGREST)
library(GO.db)
library(UpSetR)
library(seqinr)
library(pheatmap)
library(VennDiagram)
library(EnhancedVolcano)
library(tools)

#### Source custom functions
source("scripts/construct_DESeqDataSet.R")
source("scripts/order_dose.R")
source("scripts/order_timepoint.R")
source("scripts/recode_dose.R")
source("scripts/recode_timepoint.R")
source("scripts/save_DESeq2_results.R")
source("scripts/filter_DESeq2_results.R")
source("scripts/run_gsea.R")
source("scripts/generate_heatmap.R")
source("scripts/count_go.R")
source("scripts/count_kegg.R")
source("scripts/1_sample_gs_day_boxplots.R")
source("scripts/2_all_sample_pca.R")
source("scripts/3_sequence_length_histograms.R")
source("scripts/4_process_go_terms.R")
source("scripts/5_process_kegg_pathways.R")
source("scripts/6_control_skin_go_term_charts.R")
source("scripts/7_control_skin_kegg_class_charts.R")
source("scripts/8_control_skin_deg_analysis.R")
source("scripts/9_control_skin_go_enrichment.R")
source("scripts/10_control_skin_kegg_enrichment.R")
source("scripts/11_microplastics_deg_analysis.R")
source("scripts/12_microplastics_go_enrichment.R")
source("scripts/13_microplastics_kegg_enrichment.R")
source("scripts/14_control_skin_deg_venn.R")
source("scripts/15_mp_deg_upset.R")
source("scripts/16_all_sample_heatmap.R")
source("scripts/17_control_skin_deg_heatmaps.R")
source("scripts/18_mp_deg_heatmaps.R")
source("scripts/19_control_skin_gsea_dotplots_enrichment_maps.R")
source("scripts/20_mp_gsea_dotplots_enrichment_maps.R")
source("scripts/21_control_skin_volcano.R")
source("scripts/22_mp_volcano.R")
source("scripts/23_summary_stats.R")
source("scripts/24_control_skin_deg_gsea_numbers.R")
source("scripts/25_mp_deg_gsea_numbers.R")

#### Print session information
print(sessionInfo())

#### Read in information

# Annotation summary
gene_info <- read.delim("input/gene_annotation_summary.tsv",
                        row.names = 1,
                        header = FALSE)
gene_annot_summary <- gene_info$V2
names(gene_annot_summary) <- rownames(gene_info)

# GO annotations
go_annot <- read.delim("input/go_annotation.gene.tsv", header = FALSE)
# Prepare for clusterProfiler
colnames(go_annot) <- c("gene", "GO")
go_annot <- go_annot[, c("GO", "gene")]
go_annot <- separate_rows(go_annot, GO, sep = ",")
go_annot <- unique(go_annot)

# Full annotation
full_annotation_report <- read.delim("input/trinotate_report.tsv")

# Extract KEGG annotations
kegg_annot <- full_annotation_report[, c("X.gene_id", "EggNM.KEGG_Pathway")]
kegg_annot <- kegg_annot[kegg_annot$EggNM.KEGG_Pathway != ".", ]
kegg_annot <- separate_rows(kegg_annot, EggNM.KEGG_Pathway, sep = ",")
kegg_annot <- kegg_annot[!grepl("map", kegg_annot$EggNM.KEGG_Pathway), ]
colnames(kegg_annot) <- c("gene", "KEGG")
kegg_annot <- kegg_annot[, c("KEGG", "gene")]
kegg_annot <- unique(kegg_annot)

# Counts and metadata
gene_counts_file = "input/gene_count_matrix.csv"
metadata_file = "input/sample_data.txt"

gene_counts <- read.csv(gene_counts_file, row.names = "gene_id")
sample_metadata_full <- read.csv(metadata_file,
                                 sep = "\t",
                                 row.names = 1,
                                 stringsAsFactors = TRUE)
sample_metadata <- sample_metadata_full[, c("Dose", "Timepoint")]

print("Input data read")

# Other
alpha = 0.05
log2fc_threshold = 1
print("Using values:")
print(paste0("alpha: ", alpha))
print(paste0("log2fc_threshold: ", log2fc_threshold))

#### 1. Gosner stage/exposure duration boxplots
checkpoint1 <- "output/checkpoint1.ok"
if (!file.exists(checkpoint1)) {
    print("Running step 1")
    sample_gs_day_boxplots(sample_metadata_full, "output")
    file.create(checkpoint1)
} else {
    print("Skipping step 1")
}

#### 2. All sample PCA
checkpoint2 <- "output/checkpoint2.ok"
if (!file.exists(checkpoint2)) {
    print("Running step 2")
    generate_all_sample_PCA(gene_counts,
                            sample_metadata, 
                            "output/all_sample_PCA.png")
    file.create(checkpoint2)
} else {
    print("Skipping step 2")
}

#### 3. Transcript and CDS length histograms
checkpoint3 <- "output/checkpoint3.ok"
if (!file.exists(checkpoint3)) {
    print("Running step 3")
    transcript_fa <- "input/merged.wf_nuc_align.fa"
    cds_fa <- "input/merged.wf_nuc_align.fa.transdecoder.cds"
    plot_sequence_length_histograms(transcript_fa,
                                    cds_fa,
                                    "output/transcripts_length_hist.png",
                                    "output/cds_length_hist.png")
    file.create(checkpoint3)
} else {
    print("Skipping step 3")
}

#### 4. Process GO terms
checkpoint4 <- "output/checkpoint4.ok"
go_term_levels_file <- "output/go_term_levels.csv"
level2_go_terms_file <- "output/level2_go_terms.csv"
go_map_file <- "output/go_map.csv"
go_id_ont_term_file <- "output/go_id_ont_term.csv"
go_term_dict_file <- "output/go_term_dictionary.csv"
step4_Rdata <- "output/step4.Rdata"
if (!file.exists(checkpoint4)) {
    print("Running step 4")
    res4 <- process_go_terms(go_annot,
                             go_term_levels_file,
                             level2_go_terms_file,
                             go_map_file,
                             go_id_ont_term_file,
                             go_term_dict_file)
    go_map <- res4$go_map
    go_term_dict <- res4$go_term_dict
    save(go_map,
         go_term_dict,
         file = step4_Rdata)
    file.create(checkpoint4)
} else {
    print("Skipping step 4")
}

#### 5. Process KEGG Pathways
checkpoint5 <- "output/checkpoint5.ok"
kegg_pathway_classes_file <- "output/kegg_pathway_classes.csv"
kegg_map_output_file <- "output/kegg_map.csv"
kegg_pathway_dict_output_file <- "output/kegg_pathway_dictionary.csv"
step5_Rdata <- "output/step5.Rdata"
if (!file.exists(checkpoint5)) {
    print("Running step 5")
    res5 <- process_kegg_pathways(kegg_annot,
                                  kegg_pathway_classes_file,
                                  kegg_map_output_file,
                                  kegg_pathway_dict_output_file)
    kegg_map <- res5$kegg_map
    kegg_pathway_dict <- res5$kegg_pathway_dict
    save(kegg_map,
         kegg_pathway_dict,
         file = step5_Rdata)
    file.create(checkpoint5)
} else {
    print("Skipping step 5")
}

#### 6. Control skin level 2 GO term chart
checkpoint6 <- "output/checkpoint6.ok"
if (!file.exists(checkpoint6)) {
    print("Running step 6")
    load(step4_Rdata)
    #print(head(go_map))
    #print(head(go_term_dict))
    plot_control_skin_level2_go_terms(gene_counts,
                                      sample_metadata,
                                      go_map,
                                      level2_go_terms_file,
                                      "output",
                                      "_control_go_level_2_barchart.png")
    file.create(checkpoint6)
} else {
    print("Skipping step 6")
}

#### 7. Control skin KEGG class chart
checkpoint7 <- "output/checkpoint7.ok"
if (!file.exists(checkpoint7)) {
    print("Running step 7")
    load(step5_Rdata)
    #print(head(kegg_map))
    #print(head(kegg_pathway_dict))
    plot_control_skin_kegg_class_charts(gene_counts,
                                        sample_metadata,
                                        kegg_map,
                                        kegg_pathway_classes_file,
                                        "output",
                                        "_control_kegg_class_barchart.png")
    file.create(checkpoint7)
} else {
    print("Skipping step 7")
}

#### 8. Control skin DEG
checkpoint8 <- "output/checkpoint8.ok"
step8_Rdata <- "output/step8.Rdata"
if (!file.exists(checkpoint8)) {
    print("Running step 8")
    ret8 <- control_skin_deg_analysis(gene_counts,
                                      sample_metadata,
                                      "output",
                                      alpha,
                                      log2fc_threshold,
                                      gene_annot_summary)
    dds_control_t2_vs_t1 <- ret8$dds_t2_vs_t1
    res_control_t2_vs_t1 <- ret8$res_t2_vs_t1
    res_control_t2_vs_t1_filtered <- ret8$res_t2_vs_t1_filtered
    dds_control_t3_vs_t2 <- ret8$dds_t3_vs_t2
    res_control_t3_vs_t2 <- ret8$res_t3_vs_t2
    res_control_t3_vs_t2_filtered <- ret8$res_t3_vs_t2_filtered
    dds_control_t3_vs_t1 <- ret8$dds_t3_vs_t1
    res_control_t3_vs_t1 <- ret8$res_t3_vs_t1
    res_control_t3_vs_t1_filtered <- ret8$res_t3_vs_t1_filtered
    save(dds_control_t2_vs_t1,
         res_control_t2_vs_t1,
         res_control_t2_vs_t1_filtered,
         dds_control_t3_vs_t2,
         res_control_t3_vs_t2,
         res_control_t3_vs_t2_filtered,
         dds_control_t3_vs_t1,
         res_control_t3_vs_t1,
         res_control_t3_vs_t1_filtered,
         file = step8_Rdata)
    file.create(checkpoint8)
} else {
    print("Skipping step 8")
}

#### 9. Control skin GO enrichment
checkpoint9 <- "output/checkpoint9.ok"
step9_Rdata <- "output/step9.Rdata"
if (!file.exists(checkpoint9)) {
    print("Running step 9")
    load(step4_Rdata)
    load(step8_Rdata)
    #print(head(go_map))
    #print(res_control_t2_vs_t1)
    ret9 <- control_skin_go_enrichment(dds_control_t2_vs_t1,
                                       res_control_t2_vs_t1,
                                       dds_control_t3_vs_t2,
                                       res_control_t3_vs_t2,
                                       dds_control_t3_vs_t1,
                                       res_control_t3_vs_t1,
                                       go_map,
                                       go_term_dict,
                                       "output")
    go_gsea_res_control_t2_vs_t1 <- ret9$gsea_res_t2_vs_t1
    go_gsea_res_control_t3_vs_t2 <- ret9$gsea_res_t3_vs_t2
    go_gsea_res_control_t3_vs_t1 <- ret9$gsea_res_t3_vs_t1
    save(go_gsea_res_control_t2_vs_t1,
         go_gsea_res_control_t3_vs_t2,
         go_gsea_res_control_t3_vs_t1,
         file = step9_Rdata)
    file.create(checkpoint9)
} else {
    print("Skipping step 9")
}

#### 10. Control skin KEGG enrichment
checkpoint10 <- "output/checkpoint10.ok"
step10_Rdata <- "output/step10.Rdata"
if (!file.exists(checkpoint10)) {
    print("Running step 10")
    load(step5_Rdata)
    load(step8_Rdata)
    ret10 <- control_skin_kegg_enrichment(dds_control_t2_vs_t1,
                                          res_control_t2_vs_t1,
                                          dds_control_t3_vs_t2,
                                          res_control_t3_vs_t2,
                                          dds_control_t3_vs_t1,
                                          res_control_t3_vs_t1,
                                          kegg_map,
                                          kegg_pathway_dict,
                                          "output")
    kegg_gsea_res_control_t2_vs_t1 <- ret10$gsea_res_t2_vs_t1
    kegg_gsea_res_control_t3_vs_t2 <- ret10$gsea_res_t3_vs_t2
    kegg_gsea_res_control_t3_vs_t1 <- ret10$gsea_res_t3_vs_t1
    save(kegg_gsea_res_control_t2_vs_t1,
         kegg_gsea_res_control_t3_vs_t2,
         kegg_gsea_res_control_t3_vs_t1,
         file = step10_Rdata)
    file.create(checkpoint10)
} else {
    print("Skipping step 10")
}

#### 11. Microplastics DEG analysis
checkpoint11 <- "output/checkpoint11.ok"
step11_Rdata <- "output/step11.Rdata"
if (!file.exists(checkpoint11)) {
    print("Running step 11")
    ret11 <- microplastics_deg_analysis(gene_counts,
                                        sample_metadata,
                                        "output",
                                        alpha,
                                        log2fc_threshold,
                                        gene_annot_summary)
    dds_all <- ret11$dds_all
    res_low_all <- ret11$res_low_all
    res_low_all_filtered <- ret11$res_low_all_filtered
    res_high_all <- ret11$res_high_all
    res_high_all_filtered <- ret11$res_high_all_filtered
    dds_w6 <- ret11$dds_w6
    res_low_w6 <- ret11$res_low_w6
    res_low_w6_filtered <- ret11$res_low_w6_filtered
    res_high_w6 <- ret11$res_high_w6
    res_high_w6_filtered <- ret11$res_high_w6_filtered
    dds_w8 <- ret11$dds_w8
    res_low_w8 <- ret11$res_low_w8
    res_low_w8_filtered <- ret11$res_low_w8_filtered
    res_high_w8 <- ret11$res_high_w8
    res_high_w8_filtered <- ret11$res_high_w8_filtered
    dds_gs45 <- ret11$dds_gs45
    res_low_gs45 <- ret11$res_low_gs45
    res_low_gs45_filtered <- ret11$res_low_gs45_filtered
    res_high_gs45 <- ret11$res_high_gs45
    res_high_gs45_filtered <- ret11$res_high_gs45_filtered
    save(dds_all,
         res_low_all,
         res_low_all_filtered,
         res_high_all,
         res_high_all_filtered,
         dds_w6,
         res_low_w6,
         res_low_w6_filtered,
         res_high_w6,
         res_high_w6_filtered,
         dds_w8,
         res_low_w8,
         res_low_w8_filtered,
         res_high_w8,
         res_high_w8_filtered,
         dds_gs45,
         res_low_gs45,
         res_low_gs45_filtered,
         res_high_gs45,
         res_high_gs45_filtered,
         file = step11_Rdata)
    file.create(checkpoint11)
} else {
    print("Skipping step 11")
}

#### 12. Microplastics GO GSEA
checkpoint12 <- "output/checkpoint12.ok"
step12_Rdata <- "output/step12.Rdata"
if (!file.exists(checkpoint12)) {
    print("Running step 12")
    load(step4_Rdata)
    load(step11_Rdata)
    res12 <- microplastics_go_enrichment(dds_all,
                                         res_low_all,
                                         res_high_all,
                                         dds_w6,
                                         res_low_w6,
                                         res_high_w6,
                                         dds_w8,
                                         res_low_w8,
                                         res_high_w8,
                                         dds_gs45,
                                         res_low_gs45,
                                         res_high_gs45,
                                         go_map,
                                         go_term_dict,
                                         "output")
    go_gsea_res_low_all <- res12$gsea_res_low_all
    go_gsea_res_high_all <- res12$gsea_res_high_all
    go_gsea_res_low_w6 <- res12$gsea_res_low_w6
    go_gsea_res_high_w6 <- res12$gsea_res_high_w6
    go_gsea_res_low_w8 <- res12$gsea_res_low_w8
    go_gsea_res_high_w8 <- res12$gsea_res_high_w8
    go_gsea_res_low_gs45 <- res12$gsea_res_low_gs45
    go_gsea_res_high_gs45 <- res12$gsea_res_high_gs45
    save(go_gsea_res_low_all,
         go_gsea_res_high_all,
         go_gsea_res_low_w6,
         go_gsea_res_high_w6,
         go_gsea_res_low_w8,
         go_gsea_res_high_w8,
         go_gsea_res_low_gs45,
         go_gsea_res_high_gs45,
         file = step12_Rdata)
    file.create(checkpoint12)
} else {
    print("Skipping step 12")
}

#### 13. Microplastics KEGG GSEA
checkpoint13 <- "output/checkpoint13.ok"
step13_Rdata <- "output/step13.Rdata"
if (!file.exists(checkpoint13)) {
    print("Running step 13")
    load(step5_Rdata)
    load(step11_Rdata)
    res13 <- microplastics_kegg_enrichment(dds_all,
                                           res_low_all,
                                           res_high_all,
                                           dds_w6,
                                           res_low_w6,
                                           res_high_w6,
                                           dds_w8,
                                           res_low_w8,
                                           res_high_w8,
                                           dds_gs45,
                                           res_low_gs45,
                                           res_high_gs45,
                                           kegg_map,
                                           kegg_pathway_dict,
                                           "output")
    kegg_gsea_res_low_all <- res13$gsea_res_low_all
    kegg_gsea_res_high_all <- res13$gsea_res_high_all
    kegg_gsea_res_low_w6 <- res13$gsea_res_low_w6
    kegg_gsea_res_high_w6 <- res13$gsea_res_high_w6
    kegg_gsea_res_low_w8 <- res13$gsea_res_low_w8
    kegg_gsea_res_high_w8 <- res13$gsea_res_high_w8
    kegg_gsea_res_low_gs45 <- res13$gsea_res_low_gs45
    kegg_gsea_res_high_gs45 <- res13$gsea_res_high_gs45
    save(kegg_gsea_res_low_all,
         kegg_gsea_res_high_all,
         kegg_gsea_res_low_w6,
         kegg_gsea_res_high_w6,
         kegg_gsea_res_low_w8,
         kegg_gsea_res_high_w8,
         kegg_gsea_res_low_gs45,
         kegg_gsea_res_high_gs45,
         file = step13_Rdata)
    file.create(checkpoint13)
} else {
    print("Skipping step 13")
}

#### 14. Control Venn diagram
checkpoint14 <- "output/checkpoint14.ok"
if (!file.exists(checkpoint14)) {
    print("Running step 14")
    load(step8_Rdata)
    control_skin_venn(res_control_t2_vs_t1_filtered,
                      res_control_t3_vs_t2_filtered,
                      res_control_t3_vs_t1_filtered,
                      "output")
    file.create(checkpoint14)
} else {
    print("Skipping step 14")
}

#### 15. MP DEG upset plot
checkpoint15 <- "output/checkpoint15.ok"
if (!file.exists(checkpoint15)) {
    print("Running step 15")
    load(step11_Rdata)
    mp_deg_upset(res_low_w6_filtered,
                 res_high_w6_filtered,
                 res_low_w8_filtered,
                 res_high_w8_filtered,
                 res_low_gs45_filtered,
                 res_high_gs45_filtered,
                 "output")
    file.create(checkpoint15)
} else {
    print("Skipping step 15")
}

#### 16. All sample heatmap
checkpoint16 <- "output/checkpoint16.ok"
if (!file.exists(checkpoint16)) {
    print("Running step 16")
    load(step11_Rdata)
    all_sample_heatmap(dds_all,
                       sample_metadata,
                       "output")
    file.create(checkpoint16)
} else {
    print("Skipping step 16")
}

#### 17. Control skin DEG heatmaps
checkpoint17 <- "output/checkpoint17.ok"
if (!file.exists(checkpoint17)) {
    print("Running step 17")
    load(step8_Rdata)
    control_skin_deg_heatmaps(dds_control_t2_vs_t1,
                              res_control_t2_vs_t1_filtered,
                              dds_control_t3_vs_t2,
                              res_control_t3_vs_t2_filtered,
                              dds_control_t3_vs_t1,
                              res_control_t3_vs_t1_filtered,
                              sample_metadata,
                              "output")
    file.create(checkpoint17)
} else {
    print("Skipping step 17")
}

#### 18. MP DEG heatmaps
checkpoint18 <- "output/checkpoint18.ok"
if (!file.exists(checkpoint18)) {
    print("Running step 18")
    load(step11_Rdata)
    mp_deg_heatmaps(dds_w6,
                    res_low_w6_filtered,
                    res_high_w6_filtered,
                    dds_w8,
                    res_low_w8_filtered,
                    res_high_w8_filtered,
                    dds_gs45,
                    res_low_gs45_filtered,
                    res_high_gs45_filtered,
                    sample_metadata,
                    "output")
    file.create(checkpoint18)
} else {
    print("Skipping step 18")
}

#### 19. Control skin GSEA dotplots and enrichment maps
checkpoint19 <- "output/checkpoint19.ok"
if (!file.exists(checkpoint19)) {
    print("Running step 19")
    load(step9_Rdata)
    load(step10_Rdata)
    control_skin_gsea_dotplots_enrichment_maps(go_gsea_res_control_t2_vs_t1,
                                               go_gsea_res_control_t3_vs_t2,
                                               go_gsea_res_control_t3_vs_t1,
                                               kegg_gsea_res_control_t2_vs_t1,
                                               kegg_gsea_res_control_t3_vs_t2,
                                               kegg_gsea_res_control_t3_vs_t1,
                                               "output")
    file.create(checkpoint19)
} else {
    print("Skipping step 19")
}

#### 20. MP GSEA dotplots and enrichment maps
checkpoint20 <- "output/checkpoint20.ok"
if (!file.exists(checkpoint20)) {
    print("Running step 20")
    load(step12_Rdata)
    load(step13_Rdata)
    mp_gsea_dotplots_enrichment_maps(go_gsea_res_low_w6,
                                     kegg_gsea_res_low_w6,
                                     go_gsea_res_high_w6,
                                     kegg_gsea_res_high_w6,
                                     go_gsea_res_low_w8,
                                     kegg_gsea_res_low_w8,
                                     go_gsea_res_high_w8,
                                     kegg_gsea_res_high_w8,
                                     go_gsea_res_low_gs45,
                                     kegg_gsea_res_low_gs45,
                                     go_gsea_res_high_gs45,
                                     kegg_gsea_res_high_gs45,
                                     "output")
    file.create(checkpoint20)
} else {
    print("Skipping step 20")
}

#### 21. Control skin volcano plots
checkpoint21 <- "output/checkpoint21.ok"
if (!file.exists(checkpoint21)) {
    print("Running step 21")
    load(step8_Rdata)
    control_skin_volcano(res_control_t2_vs_t1,
                         res_control_t3_vs_t2,
                         res_control_t3_vs_t1,
                         "output")
    file.create(checkpoint21)
} else {
    print("Skipping step 21")
}

#### 22. MP volcano plots
checkpoint22 <- "output/checkpoint22.ok"
if (!file.exists(checkpoint22)) {
    print("Running step 22")
    load(step11_Rdata)
    mp_volcano(res_low_w6,
               res_high_w6,
               res_low_w8,
               res_high_w8,
               res_low_gs45,
               res_high_gs45,
               "output")
    file.create(checkpoint22)
} else {
    print("Skipping step 22")
}

#### 23. Summary stats
checkpoint23 <- "output/checkpoint23.ok"
if (!file.exists(checkpoint23)) {
    print("Running step 23")
    summary_stats(gene_trans_map_file = "input/merged.wf_nuc_align.gene_transcript_map.tsv",
                  transcripts_fasta_file = "input/merged.wf_nuc_align.fa",
                  cds_fasta_file = "input/merged.wf_nuc_align.fa.transdecoder.cds",
                  trinotate_report_file = "input/trinotate_report.tsv")
    file.create(checkpoint23)
} else {
    print("Skipping step 23")
}

#### 24. Control skin DEG and GSEA numbers
checkpoint24 <- "output/checkpoint24.ok"
if (!file.exists(checkpoint24)) {
    print("Running step 24")
    load(step8_Rdata)
    load(step9_Rdata)
    load(step10_Rdata)
    control_skin_deg_gsea_numbers(res_control_t2_vs_t1_filtered,
                                  res_control_t3_vs_t2_filtered,
                                  res_control_t3_vs_t1_filtered,
                                  go_gsea_res_control_t2_vs_t1,
                                  go_gsea_res_control_t3_vs_t2,
                                  go_gsea_res_control_t3_vs_t1,
                                  kegg_gsea_res_control_t2_vs_t1,
                                  kegg_gsea_res_control_t3_vs_t2,
                                  kegg_gsea_res_control_t3_vs_t1)
    file.create(checkpoint24)
} else {
    print("Skipping step 24")
}

#### 25. MP DEG and GSEA numbers
checkpoint25 <- "output/checkpoint25.ok"
if (!file.exists(checkpoint25)) {
    print("Running step 25")
    load(step11_Rdata)
    load(step12_Rdata)
    load(step13_Rdata)
    mp_deg_gsea_numbers(res_low_w6_filtered,
                        res_high_w6_filtered,
                        res_low_w8_filtered,
                        res_high_w8_filtered,
                        res_low_gs45_filtered,
                        res_high_gs45_filtered,
                        go_gsea_res_low_w6,
                        go_gsea_res_high_w6,
                        go_gsea_res_low_w8,
                        go_gsea_res_high_w8,
                        go_gsea_res_low_gs45,
                        go_gsea_res_high_gs45,
                        kegg_gsea_res_low_w6,
                        kegg_gsea_res_high_w6,
                        kegg_gsea_res_low_w8,
                        kegg_gsea_res_high_w8,
                        kegg_gsea_res_low_gs45,
                        kegg_gsea_res_high_gs45)
    file.create(checkpoint25)
} else {
    print("Skipping step 25")
}

print("Done")

# Close sink connections
sink(file = NULL, type = "message")
sink(file = NULL, type = "output")
close(log_file)
