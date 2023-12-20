# order_timepoint.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

order_timepoint <- function(data) {
    return(factor(data, c("W6", "W8", "GS45")))
    
}