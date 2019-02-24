# picfixR

#### A DSCI-524 collaborative software development project    
  
#### Project Overview

Image enhancement is typically done with a full-scale editing software such as Adobe Photoshop or GIMP, but what if we just want to quickly touch up an image during prototyping in a programming environment? 

`picfixR` allows users to quickly enhance images in an integrated development environment (IDE) (e.g. Jupyter notebook, RStudio) without powering up an image editing software. Users can quickly adjust the sharpness, contrast, and vibrance of .png images, by simply calling the corresponding functions. This package currently offers three essential image enhancement functions, and we hope to implement additional features in the near future. 

### To install
 
1\. Please ensure you have the `devtools` package already installed. If not, you can install `devtools` by running `install.packages("devtools")` at your R console.

2\. Check that you have all the required dependencies for this package installed.

3\. Install this package by running the following command at your R console.

```
devtools:: install_github("UBC-MDS/picfixR)
```

### To use

```
library(picfixR)
```

#### sharpen(): enhance the sharpness of your image

```
sharpen('input.png', 5, FALSE, 'sharpen_output.png')
```

#### contrast(): enhance the contrast of your image

```
contrast('input.png', 5, FALSE, 'contrast_output.png')
```

#### vibrance(): enhance the colour vibrance of your image  

```
vibrance('input.png', 5, FALSE, 'vibrance_output.png')
```

### Supported image types

- .png

### Dependencies

- png
- testit

#### Fitting into the R ecosystem

[magick](https://cran.r-project.org/web/packages/magick/vignettes/intro.html) provides R with a comprehensive package with an overwhelming amount of functionality for complex image processing. However, even for basic image enhancements, users typically still have to dig into a substantial amount of documentation and implementation details. This project offers a simple alternative, allowing users to have the ability to enhance images quickly during prototyping without the overhead of heavy library resources.

### Team Members

| Name                | Github handle |
| ------------------- | ------------------- |
| Miliban Keyim       | [mkeyim](https://github.com/mkeyim) |
| George J. J. Wu     | [GeorgeJJW](https://github.com/GeorgeJJw) |
| Mani Kohli          | [ksm45](https://github.com/ksm45) |
