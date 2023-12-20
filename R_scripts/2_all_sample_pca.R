# 2_all_sample_pca.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

generate_all_sample_PCA <- function(counts,
                                    sample_metadata,
                                    output_file) {
    dds <- construct_DESeqDataSet(counts,
                                  sample_metadata,
                                  design = ~ Timepoint + Dose)
    vsd <- varianceStabilizingTransformation(dds, blind = TRUE)
    pca_data <- plotPCA(vsd,
                        intgroup = c("Dose", "Timepoint"),
                        returnData = TRUE,
                        ntop = nrow(vsd))
    percent_var <- round(100* attr(pca_data, "percentVar"))
    pca_data$Dose <- order_dose(pca_data$Dose)
    pca_data$Dose <- recode_dose(pca_data$Dose)
    pca_data$Timepoint <- order_timepoint(pca_data$Timepoint)
    pca_data$Timepoint <- recode_timepoint(pca_data$Timepoint)
    pca <- ggplot(pca_data,
                  aes(x = PC1,
                      y = PC2,
                      colour = Dose,
                      shape = Timepoint)) +
        geom_point(size = 3) +
        xlab(paste0("PC1: ", percent_var[1], "% variance")) +
        ylab(paste0("PC2: ", percent_var[2], "% variance")) +
        coord_fixed() +
        theme(text = element_text(family = "Helvetica")) +
        scale_colour_manual(values = c("0×" = "#E69F00",
                                       "1×" = "#56B4E9",
                                       "10×" = "#009E73"))
    
    ggsave(output_file, plot = pca)
}