# picfixR

#### A DSCI-524 collaborative software development project    
  
## Project Overview

Image enhancement is typically done with a full-scale editing software such as Adobe Photoshop or GIMP, but what if we just want to quickly touch up an image during prototyping in a programming environment? 

`picfixR` allows users to quickly enhance images in an integrated development environment (IDE) (e.g. Jupyter notebook, RStudio) without powering up an image editing software. Users can quickly adjust the sharpness, contrast, and vibrance of .png images, by simply calling the corresponding functions. This package currently offers three essential image enhancement functions, and we hope to implement additional features in the near future. 

## To install
 
1\. Please ensure you have the `devtools` package already installed. If not, you can install `devtools` by running `install.packages("devtools")` at your R console.

2\. Check that you have all the required dependencies for this package installed.

3\. Install this package by running the following command at your R console.

```
devtools:: install_github("UBC-MDS/picfixR")
```

## To use

```
library(picfixR)
```

#### sharpen(): enhance the sharpness of your image

```
sharpen("cat.png", 8, F, "sharpen/cat_sharpen.png")
```

Arguments:

- input_img: path to an input image
- intensity: level of sharpness adjustment, between 0 and 10, defaults to 5.
- display: print image to console if `TRUE`, defaults to `FALSE`.
- output_img: path to save the output image

| Before | After sharpening |
| -- | -- |
| ![](/tests/testthat/test_img/cat.png) | ![](/tests/testthat/test_img/sharpen/cat_sharpen.png) |

#### vibrance(): enhance the colour vibrance of your image  

```
vibrance("sharpen/cat_sharpen.png", 10, F, "vibrance/cat_vibrance.png")
```

Arguments:

- input_img: path to an input image
- intensity: level of vibrance adjustment, between -10 and 10, defaults to 5.
- display: print image to console if `TRUE`, defaults to `FALSE`.
- output_img: path to save the output image

| Before | After vibrance adjustment |
| -- | -- |
| ![](/tests/testthat/test_img/sharpen/cat_sharpen.png) | ![](/tests/testthat/test_img/vibrance/cat_vibrance.png) |

#### contrast(): enhance the contrast of your image

```
contrast("vibrance/cat_vibrance.png", 1.5, F, "contrast/cat_contrast.png")
```

Arguments:

- input_img: path to an input image
- intensity: level of contrast enhancement, between 0 and 10, defaults to 5.
- display: print image to console if `TRUE`, defaults to `FALSE`.
- output_img: path to save the output image

| Before | After contrast adjustment | 
| -- | -- |
| ![](/tests/testthat/test_img/vibrance/cat_vibrance.png) | ![](/tests/testthat/test_img/contrast/cat_contrast.png) |

#### Overall results

| Raw image | After enhancements |
| -- | -- |
| ![](/tests/testthat/test_img/cat.png) | ![](/tests/testthat/test_img/contrast/cat_contrast.png) |

## Supported image types

- .png

## Dependencies

- png
- testit
- plotwidgets
- mmand

## Tests and test coverage

![tests](/tests/testthat/test_img/tests.png)

![coverage](/tests/testthat/test_img/coverage.png)

## Fitting into the R ecosystem

[magick](https://cran.r-project.org/web/packages/magick/vignettes/intro.html) provides R with a comprehensive package with an overwhelming amount of functionality for complex image processing. However, even for basic image enhancements, users typically still have to dig into a substantial amount of documentation and implementation details. This project offers a simple alternative, allowing users to have the ability to enhance images quickly during prototyping without the overhead of heavy library resources.

## Team Members

| Name                | Github handle |
| ------------------- | ------------------- |
| Miliban Keyim       | [mkeyim](https://github.com/mkeyim) |
| George J. J. Wu     | [GeorgeJJW](https://github.com/GeorgeJJw) |
| Mani Kohli          | [ksm45](https://github.com/ksm45) |
