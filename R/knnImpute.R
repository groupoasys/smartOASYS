#' K-nearest neighbors imputation
#'
#' It uses similar days of the same meter to impute the missing data of a partially observe daily function
#'
#' @param dataMatrix functions by column and missing values as NAs
#' @param k number of neighbors
#'
#' @return matrix with imputed values
#'
#' @examples
#'
#' @export
knnImpute <- function(dataMatrix, k = 1){
  partial <- names(which(colMeans(is.na(dataMatrix)) != 0))

  imputed <- dataMatrix
  for(i in 1:length(partial)){
    dist <- colMeans(sqrt((dataMatrix[,!colnames(dataMatrix) %in% partial] - dataMatrix[,partial[i]])^2), na.rm = TRUE)
    dist <- sort(dist)

    imputed[is.na(dataMatrix[,partial[i]]),partial[i]] <- rowMeans(dataMatrix[is.na(dataMatrix[,partial[i]]), names(dist)[1:k], drop = FALSE])
  }

  return(imputed)
}
