# 8_control_skin_deg_analysis.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

control_skin_deg_analysis <- function(counts,
                                      sample_metadata,
                                      output_dir,
                                      alpha,
                                      log2fc_threshold,
                                      annot_summary) {
    sample_metadata <- sample_metadata[sample_metadata$Dose == "control", ]
    sample_metadata <- sample_metadata[, "Timepoint", drop = FALSE]
    count_data <- as.matrix(counts)
    count_data <- counts[, rownames(sample_metadata)]
    
    # Verify structure of data
    stopifnot(all(rownames(sample_metadata) %in% colnames(count_data)))
    stopifnot(all(rownames(sample_metadata) == colnames(count_data)))
    
    dds_t2_vs_t1 <- construct_DESeqDataSet(count_data,
                                           sample_metadata,
                                           ~ Timepoint)
    dds_t2_vs_t1$Timepoint <- relevel(dds_t2_vs_t1$Timepoint, ref = "W6")
    
    dds_t3_vs_t2 <- construct_DESeqDataSet(count_data,
                                           sample_metadata,
                                           ~ Timepoint)
    dds_t3_vs_t2$Timepoint <- relevel(dds_t3_vs_t2$Timepoint, ref = "W8")
    
    dds_t3_vs_t1 <- construct_DESeqDataSet(count_data,
                                           sample_metadata,
                                           ~ Timepoint)
    dds_t3_vs_t1$Timepoint <- relevel(dds_t3_vs_t1$Timepoint, ref = "W6")
    
    dds_t2_vs_t1 <- DESeq(dds_t2_vs_t1)
    dds_t3_vs_t2 <- DESeq(dds_t3_vs_t2)
    dds_t3_vs_t1 <- DESeq(dds_t3_vs_t1)
    
    res_t2_vs_t1 <- results(dds_t2_vs_t1,
                            alpha = alpha,
                            contrast = c("Timepoint", "W8", "W6"))
    res_t3_vs_t2 <- results(dds_t3_vs_t2,
                            alpha = alpha,
                            contrast = c("Timepoint", "GS45", "W8"))
    res_t3_vs_t1 <- results(dds_t3_vs_t1,
                            alpha = alpha,
                            contrast = c("Timepoint", "GS45", "W6"))
    save_DESeq2_results(res_t2_vs_t1,
                        annot_summary,
                        paste0(output_dir,
                               "/control_t2_vs_t1_DEG_unfiltered.csv"))
    save_DESeq2_results(res_t3_vs_t2,
                        annot_summary,
                        paste0(output_dir,
                               "/control_t3_vs_t2_DEG_unfiltered.csv"))
    save_DESeq2_results(res_t3_vs_t1,
                        annot_summary,
                        paste0(output_dir,
                               "/control_t3_vs_t1_DEG_unfiltered.csv"))
    
    res_t2_vs_t1_filtered <- filter_DESeq2_results(res_t2_vs_t1,
                                                   alpha,
                                                   log2fc_threshold)
    res_t3_vs_t2_filtered <- filter_DESeq2_results(res_t3_vs_t2,
                                                   alpha,
                                                   log2fc_threshold)
    res_t3_vs_t1_filtered <- filter_DESeq2_results(res_t3_vs_t1,
                                                   alpha,
                                                   log2fc_threshold)
    
    save_DESeq2_results(res_t2_vs_t1_filtered,
                        annot_summary,
                        paste0(output_dir,
                               "/control_t2_vs_t1_DEG_filtered.csv"))
    save_DESeq2_results(res_t3_vs_t2_filtered,
                        annot_summary,
                        paste0(output_dir,
                               "/control_t3_vs_t2_DEG_filtered.csv"))
    save_DESeq2_results(res_t3_vs_t1_filtered,
                        annot_summary,
                        paste0(output_dir,
                               "/control_t3_vs_t1_DEG_filtered.csv"))
    
    return(list("dds_t2_vs_t1" = dds_t2_vs_t1,
                "res_t2_vs_t1" = res_t2_vs_t1,
                "res_t2_vs_t1_filtered" = res_t2_vs_t1_filtered,
                "dds_t3_vs_t2" = dds_t3_vs_t2,
                "res_t3_vs_t2" = res_t3_vs_t2,
                "res_t3_vs_t2_filtered" = res_t3_vs_t2_filtered,
                "dds_t3_vs_t1" = dds_t3_vs_t1,
                "res_t3_vs_t1" = res_t3_vs_t1,
                "res_t3_vs_t1_filtered" = res_t3_vs_t1_filtered))
}