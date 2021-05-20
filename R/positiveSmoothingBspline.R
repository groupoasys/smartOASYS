#' Positive smoothing with Bsplines
#'
#' @param matrixdata
#'
#' @return a list containing two matrices with the smooth functions and the first derivatives
#'
#' @import fda
#'
#' @examples
#'
#' @export
positiveSmoothingBspline <- function(matrixdata){
  aux <- sapply(1:ncol(matrixdata), function(x) positive_smooth_Bspline(matrixdata[,x]))

  level <- matrix(unlist(aux[1,]), ncol = ncol(matrixdata), nrow = nrow(matrixdata), byrow = FALSE)
  deriv <- matrix(unlist(aux[2,]), ncol = ncol(matrixdata), nrow = nrow(matrixdata), byrow = FALSE)

  colnames(level) <- colnames(deriv) <- colnames(matrixdata)
  rownames(level) <- rownames(deriv) <- rownames(matrixdata)

  return(list(smooth0 = level, smooth1 = deriv))
}

positive_smooth_Bspline <- function(matrixdata){

  rangeval <- c(1, length(matrixdata)) #min and max xvalues
  xeval <- seq(rangeval[1], rangeval[2], length.out = length(matrixdata))
  evalgrid <- seq(rangeval[1], rangeval[2], length.out = length(matrixdata))

  mse <- vector(mode = "numeric", length = length(c(1:21)))*NA
  for(i in c(4:100)){
    nbasis <- i

    basisobj <- create.bspline.basis(rangeval, nbasis)

    Ys <- try(smooth.pos(argvals = xeval, y = matrixdata, basisobj, dbglev = 0), silent = TRUE)

    if(class(Ys) != "try-error"){
      evalfda <- eval.posfd(evalgrid, Ys$Wfdobj)
      mse[i] <- mean((matrixdata - evalfda)^2)
    }else{
      next
    }

  }

  nbasis <- which.min(mse)
  basisobj <- create.bspline.basis(rangeval, nbasis)
  Ys <- smooth.pos(argvals = xeval, y = matrixdata, basisobj, dbglev = 0)
  evalfda <- eval.posfd(evalgrid, Ys$Wfdobj)
  evalfdaderiv <- eval.posfd(evalgrid, Ys$Wfdobj, Lfdobj = 1)

  colnames(evalfda) <- colnames(evalfdaderiv) <- colnames(matrixdata)
  rownames(evalfda) <- rownames(evalfdaderiv) <- rownames(matrixdata)

  return(list( level = evalfda, deriv = evalfdaderiv, optnbasis = nbasis))
}
