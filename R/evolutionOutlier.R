#' Evolution outlier detection method
#'
#' Compute the prototype, the distances to the prototype and provide the index of the detected outliers.
#'
#' @param dataMatrix matrix with days by columns and time of the day by row or 3dimensional array with 3dim as smart meter indicator
#' @param alpha threhold for the outlier detection rule
#'
#' @return a list with the outlier index, distances to the prototype and others.
#'
#' @import fdaoutlier fdaPOIFD matrixStats mrfDepth
#'
#' @export
#'
evolutionOutlier <- function(dataMatrix, alpha){

  if(missing(alpha)){
    alpha = 1.2
  }
  N <- dim(dataMatrix)[2]

  trimmed_mean <- rowMeans(dataMatrix[,names(sort(fdaPOIFD::POIFD(dataMatrix, type = "MBD"))[1:ceiling(0.5*N)])])
  median_f <- rowMedians(dataMatrix)

  distanceto_median <- vector(mode = "numeric", length = N)
  distanceto_trimmed_mean <- vector(mode = "numeric", length = N)

  for(i in 1:N){
    distanceto_median[i] <- sqrt(sum((dataMatrix[,i] - median_f)^2))
    distanceto_trimmed_mean[i] <- sqrt(sum((dataMatrix[,i] - trimmed_mean)^2))
  }

  rule_distanceto_median_MC <- quantile(distanceto_median, prob = 0.75) + alpha*exp(3*medcouple(distanceto_median))*IQR(distanceto_median)
  rule_distance_trimmed_mean_MC <- quantile(distanceto_trimmed_mean, prob = 0.75) + alpha*exp(3*medcouple(distanceto_trimmed_mean))*IQR(distanceto_trimmed_mean)

  out_median_MC <- colnames(dataMatrix)[distanceto_median > rule_distanceto_median_MC]
  out_trimmed_mean_MC <- colnames(dataMatrix)[distanceto_trimmed_mean > rule_distance_trimmed_mean_MC]

  rule_distanceto_median_TUKEY <- quantile(distanceto_median, prob = 0.75) + alpha*IQR(distanceto_median)
  rule_distance_trimmed_mean_TUKEY <- quantile(distanceto_trimmed_mean, prob = 0.75) + alpha*IQR(distanceto_trimmed_mean)

  out_median_TUKEY <- colnames(dataMatrix)[distanceto_median > rule_distanceto_median_TUKEY]
  out_trimmed_mean_TUKEY <- colnames(dataMatrix)[distanceto_trimmed_mean > rule_distance_trimmed_mean_TUKEY]

  return(list(distanceto_median = distanceto_median,
              distanceto_trimmed_mean = distanceto_trimmed_mean,
              out_median_MC = out_median_MC, out_trimmed_mean_MC = out_trimmed_mean_MC,
              out_median_TUKEY = out_median_TUKEY, out_trimmed_mean_TUKEY = out_trimmed_mean_TUKEY,
              rule_distanceto_median_MC = rule_distanceto_median_MC, rule_distance_trimmed_mean_MC = rule_distance_trimmed_mean_MC,
              rule_distanceto_median_TUKEY = rule_distanceto_median_TUKEY, rule_distance_trimmed_mean_TUKEY = rule_distance_trimmed_mean_TUKEY,
              trim_mean = trimmed_mean))
}
