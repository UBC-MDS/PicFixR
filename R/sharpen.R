library(png)
library(mmand)
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
#' \dontrun{
#' sharpen("./input.png", 5, FALSE, "./output.png")
#' }

sharpen <- function(input_img, intensity=5, display=F, output_img=""){

  # exception handling
  # note that other eceptions are already handled by the PNG library functions readPNG and writePNG
  testit::assert("Please provide a valid string for the input image path.", is.character(input_img))
  testit::assert("Please provide a valid string for the output image path.", is.character(output_img))
  testit::assert("Please provide an intensity value between 0 and 10.", intensity <= 10 & intensity >= 0)

  # load image with exception handling
  tryCatch(im <- png::readPNG(input_img),
           error = function (e) {
             stop("There is an error loading the image.")
           })

  # scale pixel values from [0, 1] back to [0, 255]
  im <- im * 255

  # blur image using Gaussian smoothing
  imblur <- mmand::gaussianSmooth(im, 0.75)

  # obtain sharpened image
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
    tryCatch(png::writePNG(out_im, output_img),
             error = function (e) {
               stop("There is an error saving the image.")
             })
  }
}
