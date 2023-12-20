# 6_control_skin_go_term_charts.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

plot_control_skin_level2_go_terms <- function(counts,
                                              sample_metadata,
                                              go_map,
                                              level2_go_terms_file,
                                              output_folder,
                                              output_suffix) {
    go_level_2_ont <- read.csv(level2_go_terms_file)
    go_level_2 <- go_level_2_ont$GOID
    
    go_gene <- go_map[go_map$GO %in% go_level_2, ]
    
    sample_metadata$Timepoint <- recode_timepoint(sample_metadata$Timepoint)
    for (t in levels(sample_metadata$Timepoint)) {
        t_samples <- rownames(
            sample_metadata[sample_metadata$Timepoint == t &
                                sample_metadata$Dose == "control", ])
        t_counts <- gene_counts[, t_samples]
        t_counts$sum <- rowSums(t_counts)
        t_counts <- t_counts[t_counts$sum > 0, ]
        t_expressed_genes <- row.names(t_counts)
        
        go_gene_t_expressed <- go_gene[go_gene$gene %in% t_expressed_genes, ]
        t_expressed_go_terms <- go_gene_t_expressed$GO
        
        t_go_level_2_counts <- rep(0, times = length(go_level_2))
        names(t_go_level_2_counts) <- go_level_2
        for (g in t_expressed_go_terms) {
            t_go_level_2_counts[g] <- t_go_level_2_counts[g] + 1
        }
        
        t_plot_data <- data.frame(GOID = names(t_go_level_2_counts),
                                  count = t_go_level_2_counts,
                                  stringsAsFactors = FALSE)
        t_plot_data <- merge(t_plot_data, go_level_2_ont, by = "GOID")
        terms <- select(GO.db, keys = t_plot_data$GOID, columns = "TERM", keytype = "GOID")
        t_plot_data <- merge(t_plot_data, terms, by = "GOID")
        t_plot_data <- t_plot_data[order(t_plot_data$count), ]
        t_plot_data_bp <- t_plot_data[t_plot_data$ONTOLOGY == "BP", ]
        t_plot_data_bp$ONTOLOGY <- "Biological Process"
        t_plot_data_mf <- t_plot_data[t_plot_data$ONTOLOGY == "MF", ]
        t_plot_data_mf$ONTOLOGY <- "Molecular Function"
        t_plot_data_cc <- t_plot_data[t_plot_data$ONTOLOGY == "CC", ]
        t_plot_data_cc$ONTOLOGY <- "Cellular Component"
        t_plot_data <- rbind(t_plot_data_mf, t_plot_data_cc, t_plot_data_bp)
        t_plot_data$TERM <- factor(t_plot_data$TERM, levels = t_plot_data$TERM)
        
        cbPalette <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442",
                       "#CC79A7", "#999999", "#D55E00", "#0072B2")
        plot <- ggplot(t_plot_data, aes(x = count, y = TERM, fill = ONTOLOGY)) +
            geom_col() +
            theme_classic() +
            ylab("") +
            xlab("Number of genes") +
            theme(text = element_text(family = "Helvetica"),
                  axis.text = element_text(colour = "black", size = 14),
                  axis.title.x = element_text(colour = "black", size = 14),
                  legend.title = element_blank(),
                  legend.text = element_text(colour = "black", size = 14)) +
            scale_fill_manual(values = cbPalette)
        
        ggsave(paste0(output_folder,
                      "/",
                      t,
                      output_suffix),
               plot = plot,
               width = 12,
               height = 15)
    }
}