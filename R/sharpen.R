# Install EBImmage
#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("EBImage", version = "3.8")

library(EBImage)
library(png)
library(testit)

#' Sharpen
#'
#' Sharpens an image with given intensity specification.
#' This function will use the unsharp mask approach to sharpen images.
#' Works by enhancing the edges of an image.
#'
#' @param input_img string, path of the input .png image
#' @param intensity int, intensity of sharpness enhancement, between 0 and 10, defaults to 5
#' @param display bool, if TRUE, output will be displayed. Defaults to FALSE.
#' @param output_img string, path of the output .png image
#'
#' @return a png image at the specificed out path
#' @export
#'
#' @examples
#' sharpen("./input.png", 5, FALSE, "./output.png")

sharpen <- function(input_img, intensity=5, display=F, output_img=""){

  # exception handling
  # note that other eceptions are already handled by the PNG library functions readPNG and writePNG
  testit::assert("Please provide a valid string for the input image path.", is.character(input_img))
  testit::assert("Please provide a valid string for the output image path.", is.character(output_img))
  testit::assert("Please provide an intensity value between 0 and 10.", intensity <= 10 & intensity >= 0)

  # Read Img File
  im = png::readPNG(input_img)

  # scale pixel values from [0, 1] back to [0, 255]
  im <- im * 255

  # Get Gauss
  imblur <- gblur(im, sigma=1)

  # Get Sharpened Image
  im <- (intensity + 1) * im - intensity * imblur
  zeroes <- array(0,(dim(im)))
  im <- pmax(im, zeroes)
  ones <- array(1, (dim(im)))
  im <- pmin(im, 255 * ones)

  # scale pixel values from [0, 255] to [0, 1]
  out_im <- im / 255

  # display or save enhanced image
  if (display == TRUE) {
    graphics::plot.new()
    graphics::rasterImage(out_im, 0, 0, 1, 1)
  }

  if (output_img != "") {
    png::writePNG(out_im, output_img)
  }
}
