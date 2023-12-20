# 3_sequence_length_histograms.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

plot_hist <- function(lengths, x_label, output_file, x_max, y_min, y_max) {
    hist_plot <- ggplot(mapping = aes(lengths)) +
        geom_histogram(binwidth = 500, fill = "white", colour = "black") +
        theme_classic() +
        xlab(x_label) +
        ylab("Frequency") +
        theme(text = element_text(family = "Helvetica"),
              axis.title = element_text(colour = "black", size = 14),
              axis.text = element_text(colour = "black", size = 12),
              plot.margin = margin(1, 1, 1, 1, "cm")) +
        coord_cartesian(xlim = c(-500, x_max),
                        ylim = c(y_min, y_max),
                        expand = FALSE) #+
       # facet_zoom(ylim = c(0, 1000), xlim = c(min(lengths), max(lengths)))
    ggsave(output_file, plot = hist_plot)
}

plot_sequence_length_histograms <- function(transcript_fa,
                                            cds_fa,
                                            transcript_output_file,
                                            cds_output_file) {
    transcripts <- read.fasta(file = transcript_fa, seqtype = "DNA")
    transcripts_lengths <- getLength(transcripts)
    plot_hist(transcripts_lengths,
              "Transcript length (bp)",
              transcript_output_file,
              100000,
              -25,
              20000)
    
    cds <- read.fasta(file = cds_fa, seqtype = "DNA")
    cds_lengths <- getLength(cds)
    plot_hist(cds_lengths,
              "CDS length (bp)",
              cds_output_file,
              100000,
              -100,
              80000)
    
}