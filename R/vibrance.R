library(png)


#' Vibrance
#'
#' @param input_img string, path of the input .png image
#' @param intensity int, intensity of vibrance enhancement, between 0 and 10, defaults to 5
#' @param output_img string, path of the output .png image
#'
#' @return a png image at the specificed out path
#' @export
#'
#' @examples
#' vibrance("./input.png", 5, "./output.png")
vibrance <- function(input_img, intensity=5, display=F, output_img=""){

  # exception handling
  # note that other eceptions are already handled by the PNG library functions readPNG and writePNG
  testit::assert("Please provide a valid string for the input image path.", is.character(input_img))
  testit::assert("Please provide a valid string for the output image path.", is.character(output_img))
  testit::assert("Please provide an intensity value between 0 and 10.", intensity <= 10 & intensity >= -10)

  # load input image
  img <- png::readPNG(input_img)

  # scale pixel values from [0, 1] back to [0, 255]
  img <- img * 255
}
