context("Adjust contrast of an image")

# generate input image

test_img1 <- array(c(c(1, 1, 1,
                       2, 2, 2, # R channel
                       3, 3, 3),
                     c(55, 55, 55,
                       55, 55, 55, # G channel
                       100, 100, 100),
                     c(255, 255, 255,
                       255, 255, 255, # B channel
                       5, 5, 5)),
                     dim = c(3, 3, 3))

writePNG(test_img1 / 255, "test_img/contrast/test_img1.png")

# generate expected output image when intensity is 5

expected_img1 <- array(c(c(0, 0, 0,
                           0, 0, 0, # R channel
                           0, 0, 0),
                         c(7, 7, 7,
                           7, 7, 7, # G channel
                           81, 81, 81),
                         c(255, 255, 255,
                           255, 255, 255, # B channel
                           0, 0, 0)),
                         dim = c(3, 3, 3))

# test for implementation correctness

test_that("Return identical image if intensity is 0", {

  contrast("test_img/contrast/test_img1.png", 0, F, "test_img/contrast/contrast.png")
  output_img <- readPNG("test_img/contrast/contrast.png") * 255
  expect_equal(test_img1, output_img, tolerance = 1e-5)

})

test_that("Contrast of image is correctly enhanced", {

  contrast("test_img/contrast/test_img1.png", 5, F, "test_img/contrast/contrast.png")
  output_img <- readPNG("test_img/contrast/contrast.png") * 255
  expect_equal(expected_img1, output_img, tolerance = 1e-5)

})

# test for exception handling

test_that("Input image path should be a string", {

  expect_error(contrast(888, 5, F, "test_img/contrast/contrast.png"))
  expect_error(contrast("test_img/contrast/test_img1.png", 5, F, 888))

})

test_that("Intensity should be between 0 and 10", {

  expect_error(contrast("test_img/contrast/test_img1.png", -2, F, "test_img/contrast/contrast.png"))
  expect_error(contrast("test_img/contrast/test_img1.png", 12, F, "test_img/contrast/contrast.png"))

})

test_that("Input should be an image", {

  expect_error(contrast("test_img/contrast/test_img1.R", 5, F, "test_img/contrast/contrast.png"))

})

test_that("Input image should exist", {

  expect_error(contrast("test_img/ffxiv/chocobo.png", 5, F, "test_img/contrast/contrast.pdf"))

})

test_that("Image should be displayed without errors", {
  expect_error(contrast("test_img/contrast/test_img1.png", 5, T), NA)
})

test_that("Output image path should be valid", {

  expect_error(contrast("test_img/contrast/test_img1.png", 5, F, "yolo/namazu/dailies.png"))

})
