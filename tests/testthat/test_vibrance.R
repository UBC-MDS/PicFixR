context("Adjust vibrance/saturation of an image")

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

writePNG(test_img1 / 255, "test_img/vibrance/test_img1.png")

# generate expected output image when intensity is 5

expected_img1 <- array(c(c(1, 1, 1,
                           2, 2, 2, # R channel
                           0, 0, 0),
                         c(55, 55, 55,
                           55, 55, 55, # G channel
                           103, 103, 103),
                         c(255, 255, 255,
                           255, 255, 255, # B channel
                           2, 2, 2)),
                       dim = c(3, 3, 3))

#expected greyscale image with -10 intensity in vibrance()
expected_img2 <- array(c(c(128, 128, 128,
                           128, 128, 128, # R channel
                           52, 52, 52),
                         c(128, 128, 128,
                           128, 128, 128, # G channel
                           52, 52, 52),
                         c(128, 128, 128,
                           128, 128, 128, # B channel
                           52, 52, 52)),
                       dim = c(3, 3, 3))

# test for correct vibrance

test_that("vibrance of image is correctly enhanced", {

  vibrance("test_img/vibrance/test_img1.png", 5, F, "test_img/vibrance/vibrance.png")
  output_img <- readPNG("test_img/vibrance/vibrance.png") * 255
  expect_equal(expected_img1, output_img, tolerance = 1e-5)

})

# test for greyscale vibrance with intensity set to -10

test_that("vibrance of image is correctly enhanced as greyscale", {

  vibrance("test_img/vibrance/test_img1.png", -10, F, "test_img/vibrance/vibrance.png")
  output_img <- readPNG("test_img/vibrance/vibrance.png") * 255
  expect_equal(expected_img2, output_img, tolerance = 1e-5)

})

# test for exception handling

test_that("Input image path should be a string", {

  expect_error(vibrance(888, 5, F, "test_img/vibrance/vibrance.png"))
  expect_error(vibrance("test_img/vibrance/test_img1.png", 5, F, 888))

})

test_that("Intensity should be between 0 and 10", {

  expect_error(vibrance("test_img/vibrance/test_img1.png", -12, F, "test_img/vibrance/vibrance.png"))
  expect_error(vibrance("test_img/vibrance/test_img1.png", 12, F, "test_img/vibrance/vibrance.png"))

})

test_that("Input should be an image", {

  expect_error(vibrance("test_img/vibrance/test_img1.R", 5, F, "test_img/vibrance/vibrance.png"))

})

test_that("Input image should exist", {

  expect_error(vibrance("test_img/ffxiv/chocobo.png", 5, F, "test_img/vibrance/vibrance.pdf"))

})

test_that("Image should be displayed without errors", {
  expect_error(vibrance("test_img/vibrance/test_img1.png", 5, T), NA)
})

test_that("Output image path should be valid", {

  expect_error(vibrance("test_img/vibrance/test_img1.png", 5, F, "yolo/namazu/dailies.png"))

})

