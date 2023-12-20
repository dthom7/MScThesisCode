# 1_sample_gs_day_boxplots.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

sample_gs_day_boxplots <- function(sample_metadata, output_dir) {
    sample_metadata$Dose <- order_dose(sample_metadata$Dose)
    sample_metadata$Dose <- recode_dose(sample_metadata$Dose)
    sample_metadata$Timepoint <- order_timepoint(sample_metadata$Timepoint)
    sample_metadata$Timepoint <- recode_timepoint(sample_metadata$Timepoint)
    
    gosner_stage_plot <- ggplot(sample_metadata,
                                aes(x = Dose, y = Gosner.stage)) +
        geom_boxplot(outlier.shape = NA) +
        geom_dotplot(binaxis = "y",
                     stackdir = "center",
                     dotsize = 0.5,
                     binwidth = 1) +
        facet_grid(. ~ Timepoint) +
        xlab("Microplastics Treatment") +
        ylab ("Gosner Stage") +
        theme_classic() +
        theme(text = element_text(family = "Helvetica", size = 20),
              axis.text = element_text(colour = "black"))
    
    ggsave(paste0(output_dir, "/gosner_stage_boxplot.png"),
           plot = gosner_stage_plot,
           height = 4,
           width = 8,
           dpi = 300)
    
    day_plot <- ggplot(sample_metadata,
                       aes(x = Dose, y = Sampling.day)) +
        geom_boxplot(outlier.shape = NA) +
        geom_dotplot(binaxis = "y",
                     stackdir = "center",
                     dotsize = 1,
                     binwidth = 1) +
        facet_grid(. ~ Timepoint) +
        xlab("Microplastics Treatment") +
        ylab ("Days of Exposure") +
        theme_classic() +
        theme(text = element_text(size = 20),
              axis.text = element_text(colour = "black"))
    
    ggsave(paste0(output_dir, "/sampling_day_boxplot.png"),
           plot = day_plot,
           height = 4,
           width = 8,
           dpi = 300)
}