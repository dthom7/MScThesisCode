# save_DESeq2_results.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

save_DESeq2_results <- function(res, annot, output_file) {
    res$annotation <- annot[rownames(res)]
    write.csv(as.data.frame(res), file = output_file)
}