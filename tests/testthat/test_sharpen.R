context("Sharpen an image")

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

writePNG(test_img1, "test_img/sharpen/test_img1.png")

# generate expected output image when intensity is 5

expected_img1 <- array(c(c(100, 120, 140,
                           140, 180, 250, # R channel
                           160, 220, 240),
                         c(120, 140, 110,
                           180, 250, 140, # G channel
                           220, 240, 160),
                         c(140, 110, 120,
                           250, 140, 180, # B channel
                           240, 160, 220)),
                       dim = c(3, 3, 3))

writePNG(test_img1, "test_img/sharpen/expected_img1.png")

# test for implementation correctness

test_that("Return identical image if intensity is 0", {

  sharpen("test_img/sharpen/test_img1.png", 0, "test_img/sharpen/sharpen.png")
  output_img <- readPNG("test_img/sharpen/sharpen.png")
  expect_equal(output_img, test_img1, tolarance = 1e-5)

})

test_that("sharpness of image is correctly enhanced", {

  sharpen("test_img/sharpen/test_img1.png", 5, "test_img/sharpen/sharpen.png")
  output_img <- readPNG("test_img/sharpen/sharpen.png")
  expect_equal(output_img, expected_img1, tolarance = 1e-5)

})

# test for exception handling

test_that("Input/output image path should be a string", {

  expect_error(sharpen(888, 5, "test_img/sharpen/sharpen.png"))
  expect_error(sharpen("test_img/sharpen/test_img1.png", 5, 888))

})

test_that("Intensity should be an integer between 0 and 10", {

  expect_error(sharpen("test_img/sharpen/test_img1.png", -2, "test_img/sharpen/sharpen.png"))
  expect_error(sharpen("test_img/sharpen/test_img1.png", 3.5, "test_img/sharpen/sharpen.png"))
  expect_error(sharpen("test_img/sharpen/test_img1.png", 12, "test_img/sharpen/sharpen.png"))

})

test_that("Input/output should be an image", {

  expect_error(sharpen("test_img/sharpen/test_img1.R", 5, "test_img/sharpen/sharpen.png"))
  expect_error(sharpen("test_img/sharpen/test_img1.png", 5, "test_img/sharpen/sharpen.pdf"))

})

test_that("Input image should exist", {

  expect_error(sharpen("test_img/ffxiv/chocobo.png", 5, "test_img/sharpen/sharpen.pdf"))

})

test_that("Output image path should be valid", {

  expect_error(sharpen("test_img/sharpen/test_img1.png", 5, "yolo"))

})
