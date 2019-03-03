library(png)
library(plotwidgets)

#' Vibrance
#'
#' @param input_img string, path of the input .png image
#' @param intensity int, intensity of vibrance enhancement, between -10 and 10, defaults to 5
#' @param output_img string, path of the output .png image
#' @param display bool, if TRUE, output will be displayed. Defaults to FALSE.
#'
#' @return a png image at the specificed out path
#' @export
#'
#' @examples
#' \dontrun{
#' vibrance("./input.png", 5, FALSE, "./output.png")
#' }
vibrance <- function(input_img, intensity=5, display=F, output_img=""){

  # exception handling
  # note that other exceptions are already handled by the PNG library functions readPNG and writePNG
  testit::assert("Please provide a valid string for the input image path.", is.character(input_img))
  testit::assert("Please provide a valid string for the output image path.", is.character(output_img))
  testit::assert("Please provide an intensity value between 0 and 10.", intensity <= 10 & intensity >= -10)

  # load input image
  img <- png::readPNG(input_img)

  # scale pixel values from [0, 1] back to [0, 255]
  img <- img * 255

  #getting dimensions
  height <- dim(img)[1]
  width <- dim(img)[2]

  #empty_array for output
  enhanced_img <- array(dim = dim(img))


  #nested loop - can we make this more effecient?
  for (i in 1:height) {
    for (j in 1:width) {
      R <- img[i,j,1]
      G <- img[i,j,2]
      B <- img[i,j,3]

      mat <- matrix(c(R,G,B))

      hsl <- plotwidgets::rgb2hsl(mat)

      hsl[2] = hsl[2] * (1 + intensity/10)

      if (hsl[2] > 1.0) {
        hsl[2] = 0.9
      } else {
        hsl[2] = hsl[2]
      }

      rbg <- plotwidgets::hsl2rgb(hsl)

      enhanced_img[i,j,1] = rbg[1]
      enhanced_img[i,j,2] = rbg[2]
      enhanced_img[i,j,3] = rbg[3]

    }
  }

  enhanced_img <- enhanced_img / 255

  # display or save enhanced image
  if (display == TRUE) {
    graphics::plot.new()
    graphics::rasterImage(enhanced_img, 0, 0, 1, 1)
  }

  if (output_img != "") {
    png::writePNG(enhanced_img, output_img)
  }

}
