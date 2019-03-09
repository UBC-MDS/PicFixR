library(png)
library(plotwidgets)

#' Vibrance
#'
#' @param input_img string, path of the input .png image
#' @param intensity int, intensity of vibrance enhancement, between -10 and 10, defaults to 5
#' @param display bool, if TRUE, output will be displayed. Defaults to FALSE.
#' @param output_img string, path of the output .png image
#'
#' @return a png image at the specificed out path
#' @export
#'
#' @examples
#' \dontrun{
#' vibrance("./input.png", 5, FALSE, "./output.png")
#' }
vibrance <- function(input_img, intensity=5, display=F, output_img=""){

  # argument validations
  testit::assert("Please provide a valid string for the input image path.", is.character(input_img))
  testit::assert("Please provide a valid string for the output image path.", is.character(output_img))
  testit::assert("Please provide an intensity value between 0 and 10.", intensity <= 10 & intensity >= -10)

  # load input image with exception handling
  tryCatch(img <- png::readPNG(input_img),
           error = function (e) {
             stop("There is an error loading the image.")
           })

  # scale pixel values from [0, 1] back to [0, 255]
  img <- img * 255

  #getting dimensions
  height <- dim(img)[1]

  #transposed matrix array to get in order of RGB
  t_matrix <- aperm(img, c(3,2,1))

  #empty_array for output
  enhanced_img <- array(dim = dim(img))

  #2 linear loops needed for vectorizing & changing to HSL format instead if
  for (i in (1:height)) {
    t_matrix[,,i] <- plotwidgets::rgb2hsl(t_matrix[,,i])
  }

  # adjusting intensity
  t_matrix[2,,] <- t_matrix[2,,] * (1 + (intensity)/10)
  t_matrix[2,,] <- ifelse(t_matrix[2,,] > 1.0, 1.0, t_matrix[2,,])

  # returnin
  for (i in (1:height)) {
    t_matrix[,,i] <- plotwidgets::hsl2rgb(t_matrix[,,i])
  }

  enhanced_img <- aperm(t_matrix, c(3, 2, 1))
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
