# order_dose.R
# Author: Drew Thompson
# Email: drew.thompson@uwaterloo.ca

order_dose <- function(data) {
    return(factor(data, c("control", "low", "high")))
}