# construct_DESeqDataSet.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

construct_DESeqDataSet <- function(counts,
                                   sample_metadata,
                                   design,
                                   filter = TRUE,
                                   smallestGroupSize = 3,
                                   minCount = 10) {
    count_data <- as.matrix(counts)
    count_data <- count_data[, rownames(sample_metadata)]
    
    # Verify structure of data
    stopifnot(all(rownames(sample_metadata) %in% colnames(count_data)))
    stopifnot(all(rownames(sample_metadata) == colnames(count_data)))
    
    dds <- DESeqDataSetFromMatrix(countData = count_data,
                                  colData = sample_metadata,
                                  design = design)
    
    if (filter == TRUE) {
        print(paste0("dds rows pre-filtering: ", nrow(dds)))
        keep <- rowSums(counts(dds) >= minCount) >= smallestGroupSize
        dds <- dds[keep, ]
        print(paste0("dds rows post-filtering: ", nrow(dds)))
    }
    
    return(dds)
}