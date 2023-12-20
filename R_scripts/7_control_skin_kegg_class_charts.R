# 7_control_skin_kegg_class_charts.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

plot_control_skin_kegg_class_charts <- function(counts,
                                                sample_metadata,
                                                kegg_map,
                                                kegg_classes_file,
                                                output_dir,
                                                output_suffix) {
    kegg_categories <- read.csv(kegg_classes_file)
    kegg_annot <- kegg_map[kegg_map$KEGG %in% kegg_categories$ID, ]
    
    sample_metadata$Timepoint <- recode_timepoint(sample_metadata$Timepoint)
    for (t in levels(sample_metadata$Timepoint)) {
        t_samples <- rownames(
            sample_metadata[sample_metadata$Timepoint == t &
                                sample_metadata$Dose == "control", ])
        t_counts <- gene_counts[, t_samples]
        t_counts$sum <- rowSums(t_counts)
        t_counts <- t_counts[t_counts$sum > 0, ]
        t_expressed_genes <- row.names(t_counts)
        
        kegg_annot_t_expressed <- kegg_annot[kegg_annot$gene %in% t_expressed_genes, ]
        t_expressed_kegg <- kegg_annot_t_expressed$KEGG
        
        t_kegg_category_counts <- rep(0, times = nrow(kegg_categories))
        names(t_kegg_category_counts) <- kegg_categories$ID
        for (k in t_expressed_kegg) {
            t_kegg_category_counts[k] <- t_kegg_category_counts[k] + 1
        }
        
        t_plot_data <- data.frame(ID = names(t_kegg_category_counts),
                                  count = t_kegg_category_counts,
                                  stringsAsFactors = FALSE)
        t_plot_data <- merge(kegg_categories, t_plot_data, by = "ID")
        t_plot_data <- t_plot_data[, c("CLASS", "count")]
        t_plot_data <- t_plot_data %>%
            group_by(CLASS) %>%
            summarise(sum = sum(count))
        t_plot_data <- separate_wider_delim(t_plot_data,
                                            cols = CLASS,
                                            delim = "; ",
                                            names = c("level1", "level2"))
        t_plot_data$level1 <- factor(t_plot_data$level1)
        t_plot_data$level1 <- factor(t_plot_data$level1, levels = rev(levels(t_plot_data$level1)))
        t_plot_data <- t_plot_data[order(t_plot_data$level1, t_plot_data$sum, decreasing = TRUE), ]
        t_plot_data$level2 <- factor(t_plot_data$level2, levels = t_plot_data$level2)
        
        cbPalette <- c("#999999", "#CC79A7", "#F0E442", "#009E73",
                       "#56B4E9", "#E69F00", "#D55E00", "#0072B2")
        plot <- ggplot(t_plot_data, aes(x = sum, y = level2, fill = level1)) +
            geom_col() +
            theme_classic() +
            ylab("") +
            xlab("Number of genes") +
            theme(text = element_text(family = "Helvetica"),
                  axis.text = element_text(colour = "black", size = 14),
                  axis.title.x = element_text(colour = "black", size = 14),
                  legend.title = element_blank(),
                  legend.text = element_text(colour = "black", size = 14)) +
            scale_y_discrete(limits = rev) +
            guides(fill = guide_legend(reverse = TRUE)) +
            scale_fill_manual(values = cbPalette)
            
        
        ggsave(paste0(output_dir,
                      "/",
                      t,
                      output_suffix),
               plot = plot,
               width = 12,
               height = 15)
    }
}