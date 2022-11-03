#' Compute Fuctional Depths and Transformations
#'
#' One meter data
#'
#' @param dataMatrix matrix with days by columns and time of the day by row or 3dimensional array with 3dim as smart meter indicator
#' @param typeDepth depth measure to compute
#'
#' @return
#'
#' @examples
#'
#' @import fdaoutlier fdaPOIFD
#'
#' @export
#'
#'
timeDepth <- function(dataMatrix, typeDepth){
  if(length(dim(dataMatrix)) == 2){
    output <- timeDepthOne(dataMatrix, typeDepth)
  }

  if(length(dim(dataMatrix)) == 3){
    output <- timeDepthHD(dataMatrix, typeDepth)
  }
  return(output)
}

timeDepthOne <- function(dataMatrix, typeDepth){
    if(typeDepth == "FMD"){
      depth <- fdaPOIFD::POIFD(dataMatrix, type = "FMD")
    }

    if(typeDepth == "MBD"){
      depth <- fdaPOIFD::POIFD(dataMatrix, type = "MBD")
    }

    if(typeDepth == "MHRD"){
      depth <- fdaPOIFD::POIFD(dataMatrix, type = "MHRD")
    }

    if(typeDepth == "EXTD"){
      depth <- fdaoutlier::extremal_depth(t(dataMatrix))
      names(depth) <- colnames(dataMatrix)
    }

    if(typeDepth == "INFD"){
      depth <- fdaoutlier::linfinity_depth(t(dataMatrix))
      names(depth) <- colnames(dataMatrix)
    }

    mhrd <- fdaPOIFD::POIFD(dataMatrix, type = "MHRD")

  dates <- colnames(dataMatrix)
  depth_time <- depth[dates]
  hipos <- mhrd$mhipo[dates]
  trans_depth <- -sign(hipos - hipos[names(which.max(depth_time))])*(depth_time-max(depth_time, na.rm = TRUE))

  #names(hipos) <- names(depth_time) <- names(trans_depth) <- colnames(dataMatrix)

  return(list(depth = depth_time,
              transDepth = trans_depth,
              mhipo = hipos))
}

timeDepthHD <- function(dataMatrix, typeDepth){
  sapply(1:dim(dataMatrix)[1], function(x) timeDepth(dataMatrix[x,,], typeDepth))
}
