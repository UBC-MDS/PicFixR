context("Adjust sharpness of an image")

# generate input image

test_img1  <- array(c(c(0, 50, 200,
                        0, 50, 200, # R channel
                        0, 50, 200),
                      c(0, 50, 200,
                        0, 50, 200, # G channel
                        0, 50, 200),
                      c(0, 50, 200,
                        0, 50, 200, # B channel
                        0, 50, 200)),
                      dim = c(3, 3, 3))

writePNG(test_img1 / 255, "test_img/sharpen/test_img1.png")

# generate expected output image when intensity is 5

expected_img1 <- array(c(c(0, 0, 255,
                           0, 0, 255, # R channel
                           0, 0, 255),
                         c(0, 0, 255,
                           0, 0, 255, # G channel
                           0, 0, 255),
                         c(0, 0, 255,
                           0, 0, 255, # B channel
                           0, 0, 255)),
                       dim = c(3, 3, 3))

# test for implementation correctness

test_that("Return identical image if intensity is 0", {

  sharpen("test_img/sharpen/test_img1.png", 0, F, "test_img/sharpen/sharpen.png")
  output_img <- readPNG("test_img/sharpen/sharpen.png") * 255
  expect_equal(output_img, test_img1, tolarance = 1e-5)

})

test_that("sharpness of image is correctly enhanced", {

  sharpen("test_img/sharpen/test_img1.png", 5, F, "test_img/sharpen/sharpen.png")
  output_img <- readPNG("test_img/sharpen/sharpen.png") * 255
  expect_equal(output_img, expected_img1, tolarance = 1e-5)

})

# test for exception handling

test_that("Input/output image path should be a string", {

  expect_error(sharpen(888, 5, F, "test_img/sharpen/sharpen.png"))
  expect_error(sharpen("test_img/sharpen/test_img1.png", 5, F, 888))

})

test_that("Intensity should be between 0 and 10", {

  expect_error(sharpen("test_img/sharpen/test_img1.png", -2, F, "test_img/sharpen/sharpen.png"))
  expect_error(sharpen("test_img/sharpen/test_img1.png", 12, F, "test_img/sharpen/sharpen.png"))

})

test_that("Input/output should be an image", {

  expect_error(sharpen("test_img/sharpen/test_img1.R", 5, F, "test_img/sharpen/sharpen.png"))

})

test_that("Input image should exist", {

  expect_error(sharpen("test_img/ffxiv/chocobo.png", 5, F, "test_img/sharpen/sharpen.pdf"))

})

test_that("Image should be displayed without errors", {
  expect_error(sharpen("test_img/sharpen/test_img1.png", 5, T), NA)
})

test_that("Output image path should be valid", {

  expect_error(sharpen("test_img/sharpen/test_img1.png", 5, F, "yolo/namazu/dailies.png"))

})
