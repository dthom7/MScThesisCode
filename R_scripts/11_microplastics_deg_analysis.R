# 11_microplastics_deg_analysis
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

microplastics_deg_analysis <- function(counts,
                                       sample_metadata,
                                       output_dir,
                                       alpha,
                                       log2fc_threshold,
                                       annot_summary) {
    
    print("DEG: All timepoints")
    # All timepoints
    dds_all <- construct_DESeqDataSet(counts,
                                      sample_metadata,
                                      ~ Timepoint + Dose)
    dds_all$Dose <- relevel(dds_all$Dose, ref = "control")
    dds_all <- DESeq(dds_all)
    
    print("1×")
    # All 1×
    res_low_all <- results(dds_all,
                           alpha = alpha,
                           contrast = c("Dose", "low", "control"))
    save_DESeq2_results(res_low_all,
                        annot_summary,
                        paste0(output_dir,
                               "/all_timepoints_1×_DEG_unfiltered.csv"))
    res_low_all_filtered <- filter_DESeq2_results(res_low_all,
                                                  alpha,
                                                  log2fc_threshold)
    save_DESeq2_results(res_low_all_filtered,
                        annot_summary,
                        paste0(output_dir,
                               "/all_timepoints_1×_DEG_filtered.csv"))
    
    print("10×")
    # All 10×
    res_high_all <- results(dds_all,
                            alpha = alpha,
                            contrast = c("Dose", "high", "control"))
    save_DESeq2_results(res_high_all,
                        annot_summary,
                        paste0(output_dir,
                               "/all_timepoints_10×_DEG_unfiltered.csv"))
    res_high_all_filtered <- filter_DESeq2_results(res_high_all,
                                                   alpha,
                                                   log2fc_threshold)
    save_DESeq2_results(res_high_all_filtered,
                        annot_summary,
                        paste0(output_dir,
                               "/all_timepoints_10×_DEG_filtered.csv"))
    
    print("DEG: GS~34 timepoint")
    # GS~34
    sample_metadata_w6 <- sample_metadata[sample_metadata$Timepoint == "W6",
                                          "Dose",
                                          drop = FALSE]
    dds_w6 <- construct_DESeqDataSet(counts,
                                     sample_metadata_w6,
                                     ~ Dose)
    dds_w6$Dose <- relevel(dds_w6$Dose, ref = "control")
    dds_w6 <- DESeq(dds_w6)
    
    print("1×")
    # GS~34 1×
    res_low_w6 <- results(dds_w6,
                          alpha = alpha,
                          contrast = c("Dose", "low", "control"))
    save_DESeq2_results(res_low_w6,
                        annot_summary,
                        paste0(output_dir,
                               "/GS~34_1×_DEG_unfiltered.csv"))
    res_low_w6_filtered <- filter_DESeq2_results(res_low_w6,
                                                 alpha,
                                                 log2fc_threshold)
    save_DESeq2_results(res_low_w6_filtered,
                        annot_summary,
                        paste0(output_dir,
                               "/GS~34_1×_DEG_filtered.csv"))
    
    print("10×")
    # GS~34 10×
    res_high_w6 <- results(dds_w6,
                           alpha = alpha,
                           contrast = c("Dose", "high", "control"))
    save_DESeq2_results(res_high_w6,
                        annot_summary,
                        paste0(output_dir,
                               "/GS~34_10×_DEG_unfiltered.csv"))
    res_high_w6_filtered <- filter_DESeq2_results(res_high_w6,
                                                  alpha,
                                                  log2fc_threshold)
    save_DESeq2_results(res_high_w6_filtered,
                        annot_summary,
                        paste0(output_dir,
                               "/GS~34_10×_DEG_filtered.csv"))
    
    print("DEG: GS~42 timepoint")
    # GS~42
    sample_metadata_w8 <- sample_metadata[sample_metadata$Timepoint == "W8",
                                          "Dose",
                                          drop = FALSE]
    dds_w8 <- construct_DESeqDataSet(counts,
                                     sample_metadata_w8,
                                     ~ Dose)
    dds_w8$Dose <- relevel(dds_w8$Dose, ref = "control")
    dds_w8 <- DESeq(dds_w8)
    
    print("1×")
    # GS~42 1×
    res_low_w8 <- results(dds_w8,
                          alpha = alpha,
                          contrast = c("Dose", "low", "control"))
    save_DESeq2_results(res_low_w8,
                        annot_summary,
                        paste0(output_dir,
                               "/GS~42_1×_DEG_unfiltered.csv"))
    res_low_w8_filtered <- filter_DESeq2_results(res_low_w8,
                                                 alpha,
                                                 log2fc_threshold)
    save_DESeq2_results(res_low_w8_filtered,
                        annot_summary,
                        paste0(output_dir,
                               "/GS~42_1×_DEG_filtered.csv"))
    
    print("10×")
    # GS~42 10×
    res_high_w8 <- results(dds_w8,
                           alpha = alpha,
                           contrast = c("Dose", "high", "control"))
    save_DESeq2_results(res_high_w8,
                        annot_summary,
                        paste0(output_dir,
                               "/GS~42_10×_DEG_unfiltered.csv"))
    res_high_w8_filtered <- filter_DESeq2_results(res_high_w8,
                                                  alpha,
                                                  log2fc_threshold)
    save_DESeq2_results(res_high_w8_filtered,
                        annot_summary,
                        paste0(output_dir,
                               "/GS~42_10×_DEG_filtered.csv"))
    
    print("DEG: GS45 timepoint")
    # GS45
    sample_metadata_gs45 <- sample_metadata[sample_metadata$Timepoint == "GS45",
                                            "Dose",
                                            drop = FALSE]
    dds_gs45 <- construct_DESeqDataSet(counts,
                                       sample_metadata_gs45,
                                       ~ Dose,
                                       smallestGroupSize = 4)
    dds_gs45$Dose <- relevel(dds_gs45$Dose, ref = "control")
    dds_gs45 <- DESeq(dds_gs45)
    
    print("1×")
    # GS45 1×
    res_low_gs45 <- results(dds_gs45,
                            alpha = alpha,
                            contrast = c("Dose", "low", "control"))
    save_DESeq2_results(res_low_gs45,
                        annot_summary,
                        paste0(output_dir,
                               "/GS45_1×_DEG_unfiltered.csv"))
    res_low_gs45_filtered <- filter_DESeq2_results(res_low_gs45,
                                                   alpha,
                                                   log2fc_threshold)
    save_DESeq2_results(res_low_gs45_filtered,
                        annot_summary,
                        paste0(output_dir,
                               "/GS45_1×_DEG_filtered.csv"))
    
    print("10×")
    # GS45 10×
    res_high_gs45 <- results(dds_gs45,
                             alpha = alpha,
                             contrast = c("Dose", "high", "control"))
    save_DESeq2_results(res_high_gs45,
                        annot_summary,
                        paste0(output_dir,
                               "/GS45_10×_DEG_unfiltered.csv"))
    res_high_gs45_filtered <- filter_DESeq2_results(res_high_gs45,
                                                    alpha,
                                                    log2fc_threshold)
    save_DESeq2_results(res_high_gs45_filtered,
                        annot_summary,
                        paste0(output_dir,
                               "/GS45_10×_DEG_filtered.csv"))
    
    return(list(dds_all = dds_all,
                res_low_all = res_low_all,
                res_low_all_filtered = res_low_all_filtered,
                res_high_all = res_high_all,
                res_high_all_filtered = res_high_all_filtered,
                dds_w6 = dds_w6,
                res_low_w6 = res_low_w6,
                res_low_w6_filtered = res_low_w6_filtered,
                res_high_w6 = res_high_w6,
                res_high_w6_filtered = res_high_w6_filtered,
                dds_w8 = dds_w8,
                res_low_w8 = res_low_w8,
                res_low_w8_filtered = res_low_w8_filtered,
                res_high_w8 = res_high_w8,
                res_high_w8_filtered = res_high_w8_filtered,
                dds_gs45 = dds_gs45,
                res_low_gs45 = res_low_gs45,
                res_low_gs45_filtered = res_low_gs45_filtered,
                res_high_gs45 = res_high_gs45,
                res_high_gs45_filtered = res_high_gs45_filtered))
}