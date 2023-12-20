# generate_heatmap.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

generate_heatmap <- function(dds,
                             sample_metadata,
                             output_file,
                             annotation_colours =
                                 list(Timepoint = c("GS ~34" = "#F0E442",
                                                    "GS ~42" = "#0072B2",
                                                    "GS 45" = "#D55E00"),
                                      Dose = c("0×" = "#E69F00",
                                               "1×" = "#56B4E9",
                                               "10×" = "#009E73")),
                             gene_list = NULL,
                             n_genes_to_plot = NULL,
                             rename_dose = TRUE,
                             filter_samples = FALSE) {
    vsd <- varianceStabilizingTransformation(dds, blind = TRUE)
    vsm <- assay(vsd)
    vsm <- as.data.frame(vsm)
    
    if (!is.null(gene_list)) {
        vsm <- vsm[rownames(vsm) %in% gene_list, ]
    }
    if (!is.null(n_genes_to_plot)) {
        vsm_vars <- rowVars(as.matrix(vsm))
        vsm <- vsm[order(vsm_vars, decreasing = TRUE), ]
        vsm <- vsm[1:n_genes_to_plot, ]
    }
    if (filter_samples == TRUE) {
        vsm <- vsm[, rownames(sample_metadata)]
    }
    
    vsm <- as.matrix(vsm)
    
    if (rename_dose == TRUE) {
        sample_metadata$Dose <- order_dose(sample_metadata$Dose)
        sample_metadata$Dose <- recode_dose(sample_metadata$Dose)
    }
    
    sample_metadata$Timepoint <- order_timepoint(sample_metadata$Timepoint)
    sample_metadata$Timepoint <- recode_timepoint(sample_metadata$Timepoint)
    
    
    pheatmap(t(scale(t(vsm))),
             show_rownames = FALSE,
             show_colnames = TRUE,
             annotation_col = sample_metadata,
             border_color = NA,
             annotation_colors = annotation_colours,
             fontfamily = "Helvetica",
             filename = output_file)
}