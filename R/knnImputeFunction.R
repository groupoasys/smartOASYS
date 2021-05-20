#' K-nearest neighbors imputation
#'
#' It uses similar meters of the same meter to impute the missing daily function
#´
#' @param data 3dimensional array
#' @param k number of neighbourds. Default is 1.
#'
#' @return 3dimensional array with imputed values
#' @export
#'
#' @examples
knnImputeFunction <- function(data, k = 1){

  for(i in id_f_missing){
    l2MeanDist <- sapply(c(1:dim(data)[3])[-i], function(x) mean(sqrt(colSums((data[,,x] - data[,,i])^2, na.rm = TRUE))))
    names(l2MeanDist) <- dimnames(data)[[3]][-i]

    #remove nearest neighbour with missing functions
    l2MeanDist <- sort(l2MeanDist[!names(l2MeanDist) %in% dimnames(data)[[3]][id_f_missing]])

    impute_dates <- names(which(colMeans(is.na(data[,,i])) == 1))
    for(j in impute_dates){
      data[,j,i] <- rowMeans(data[,j,names(l2MeanDist)[1:min(k, length(l2MeanDist))], drop=FALSE],
                             na.rm = TRUE)
    }
  }

  return(data)
}
