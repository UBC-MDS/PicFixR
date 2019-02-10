context("Adjust contrast of an image")

# generate input image

test_img1 <- array(c(c(4, 44, 60,
                         6, 33, 22, # R channel
                         4, 65, 33),
                       c(77, 44, 70,
                         66, 55, 56, # G channel
                         55, 77, 45),
                       c(245, 32, 80,
                         43, 63, 70, # B channel
                         66, 43, 22)),
                     dim = c(3, 3, 3))

writePNG(test_img1, "test_img/contrast/test_img1.png")

# generate expected output image when intensity is 5

expected_img1 <- array(c(c(2, 44, 60,
                           4, 33, 22, # R channel
                           2, 65, 33),
                         c(33, 44, 70,
                           22, 55, 56, # G channel
                           42, 77, 45),
                         c(143, 32, 80,
                           33, 63, 70, # B channel
                           24, 43, 22)),
                       dim = c(3, 3, 3))

writePNG(test_img1, "test_img/contrast/expected_img1.png")

# test for implementation correctness

test_that("Return identical image if intensity is 0", {

  contrast("test_img/contrast/test_img1.png", 0, "test_img/contrast/contrast.png")
  output_img <- readPNG("test_img/contrast/contrast.png")
  expect_equal(output_img, test_img1, tolarance = 1e-5)

})

test_that("Contrast of image is correctly enhanced", {

  contrast("test_img/contrast/test_img1.png", 5, "test_img/contrast/contrast.png")
  output_img <- readPNG("test_img/contrast/contrast.png")
  expect_equal(output_img, expected_img1, tolarance = 1e-5)

})

# test for exception handling

test_that("Input/output image path should be a string", {

  expect_error(contrast(888, 5, "test_img/contrast/contrast.png"))
  expect_error(contrast("test_img/contrast/test_img1.png", 5, 888))

})

test_that("Intensity should be an integer between 0 and 10", {

  expect_error(contrast("test_img/contrast/test_img1.png", -2, "test_img/contrast/contrast.png"))
  expect_error(contrast("test_img/contrast/test_img1.png", 3.5, "test_img/contrast/contrast.png"))
  expect_error(contrast("test_img/contrast/test_img1.png", 12, "test_img/contrast/contrast.png"))

})

test_that("Input/output should be an image", {

  expect_error(contrast("test_img/contrast/test_img1.R", 5, "test_img/contrast/contrast.png"))
  expect_error(contrast("test_img/contrast/test_img1.png", 5, "test_img/contrast/contrast.pdf"))

})

test_that("Input image should exist", {

  expect_error(contrast("test_img/ffxiv/chocobo.png", 5, "test_img/contrast/contrast.pdf"))

})

test_that("Output image path should be valid", {

  expect_error(contrast("test_img/contrast/test_img1.png", 5, "\,,/(^_^)\,,/"))

})
