#' Preprocess solar generation
#'
#' @param data matrix or 3dimensional array.
#' @param k if missing data, number of neighbors for the imputation method.
#'
#' @return a list containing three matrices with the raw curves, smooth functions and the first derivatives
#' @export
#'
#' @examples
preProcessSolarData <- function(data, k){
  if(missing(k)){k = 1}

  if(length(dim(data)) == 2){
    # remove no generation periods
    data <- data[apply(data, 1, sd, na.rm = TRUE) > 0,]

    # Impute missing data
    data <- knnImpute(data, k)

    # smooth functions
    data_smooth <- positiveSmoothingBspline(data)

    return(list(raw0 = data, smooth0 = data_smooth$smooth0, smooth1 = data_smooth$smooth1))
  }

  if(length(dim(data)) == 3){
    # remove no generation periods
    data <- data[dimnames(data)[[1]][which(sapply(1:dim(data)[1], function(x) sd(data[x,,], na.rm = TRUE)) > 0)],,]

    # no complete missing days
    id_f_missing <- which(sapply(1:dim(data)[3], function(x) sum(colMeans(is.na(data[,,x])) == 1)) != 0)
    if(length(id_f_missing) != 0){
      message(paste0("Some IDs present complete missing days and were imputed: ", paste(dimnames(data)[[3]][id_f_missing], collapse = " ")))
      data <- knnImputeFunction(data, k = 1)
    }

    preProcessedData <- apply(data, 3, preProcessSolarData_aux, k)
    raw0 <- smooth0 <- smooth1 <- array(NA, dim = dim(data),
                                        dimnames = dimnames(data))

    for(i in 1:length(preProcessedData)){
      raw0[rownames(preProcessedData[[i]]$raw0), colnames(preProcessedData[[i]]$raw0), i] <- preProcessedData[[i]]$raw0
      smooth0[rownames(preProcessedData[[i]]$smooth0), colnames( preProcessedData[[i]]$smooth0), i] <- preProcessedData[[i]]$smooth0
      smooth1[rownames(preProcessedData[[i]]$smooth1), colnames( preProcessedData[[i]]$smooth1), i] <- preProcessedData[[i]]$smooth1
    }

    return(list(raw0 = raw0, smooth0 = smooth0, smooth1 = smooth1))
  }
}

preProcessSolarData_aux <- function(data, k){
  # Impute missing data
  data <- knnImpute(data, k)

  # smooth functions
  data_smooth <- positiveSmoothingBspline(data)

  return(list(raw0 = data, smooth0 = data_smooth$smooth0, smooth1 = data_smooth$smooth1))
}
