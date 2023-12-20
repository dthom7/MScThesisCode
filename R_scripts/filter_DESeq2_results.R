# filter_DESeq2_results.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

filter_DESeq2_results <- function(res, alpha, log2fc_threshold) {
    print(paste0("nrows pre-filtering: ", nrow(res)))
    res <- res[complete.cases(res$log2FoldChange), ]
    print(paste0("nrows post-null lfc filtering: ", nrow(res)))
    res <- res[complete.cases(res$padj), ]
    print(paste0("nrows post-null padj filtering: ", nrow(res)))
    res <- res[abs(res$log2FoldChange) > log2fc_threshold, ]
    print(paste0("nrows post-lfc filtering: ", nrow(res)))
    res <- res[res$padj < alpha, ]
    print(paste0("nrows post-padj filtering: ", nrow(res)))
    
    res <- res[order(res$padj), ]
    
    return(res)
}