library(png)
library(testit)

#' Adjust contrast of image
#'
#' Adjust the contrast of an image, given the intensity specification.
#' Works by making dark pixels much darker, and light pixels only slighly darker.
#'
#' @param input_img string, path of the input image
#' @param intensity int, intensity of contrast enhancement, between 0 and 10, defaults to 5
#' @param display bool, if TRUE, output will be displayed. Defaults to FALSE.
#' @param output_img string, path of the output image
#'
#' @return an image at the specificed output path
#' @export
#'
#' @examples
#' \dontrun{
#' contrast("./input.png", 5, FALSE, "./output.png")
#' }

contrast <- function(input_img, intensity=5, display=F, output_img="") {

  # exception handling
  # note that other eceptions are already handled by the PNG library functions readPNG and writePNG
  testit::assert("Please provide a valid string for the input image path.", is.character(input_img))
  testit::assert("Please provide a valid string for the output image path.", is.character(output_img))
  testit::assert("Please provide an intensity value between 0 and 10.", intensity <= 10 & intensity >= 0)

  # load input image with exception handling
  tryCatch(img <- png::readPNG(input_img),
           error = function (e) {
             stop("There is an error loading the image.")
           })

  # scale pixel values from [0, 1] back to [0, 255]
  img <- img * 255

  # map intensity to desired level of contrast
  # attribution: https://stackoverflow.com/questions/345187/math-mapping-numbers
  c_level <- intensity / 10 * 128

  # convert desired level of contrast to a contrast correction factor
  # attribution: https://bit.ly/2EObG6B
  c_factor <- (259 * (c_level + 255)) / (255 * (259 - c_level))

  # perform contrast enhancement
  enhanced_img <- c_factor * (img - 128) + 128

  # restrict pixel values back to [0, 255]
  zeroes <- array(0, c(dim(img)[1], dim(img)[2], dim(img)[3]))
  two_fifties <- array(255, c(dim(img)[1], dim(img)[2], dim(img)[3]))
  enhanced_img <- pmax(enhanced_img, zeroes)
  enhanced_img <- pmin(enhanced_img, two_fifties)

  # scale pixel values from [0, 255] to [0, 1]
  enhanced_img <- enhanced_img / 255

  # display or save enhanced image
  if (display == TRUE) {
    graphics::plot.new()
    graphics::rasterImage(enhanced_img, 0, 0, 1, 1)
  }

  if (output_img != "") {
    tryCatch(png::writePNG(enhanced_img, output_img),
             error = function (e) {
               stop("There is an error saving the image.")
             })
  }

}
