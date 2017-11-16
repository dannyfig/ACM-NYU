## An Introduction to Data Analysis in R

### Installation

#### R

If you have [brew](https://brew.sh/) or really any other package manager, this whole process is much tidier:

```bash
$ brew install r
```

Otherwise, you'll have to use the GUI at the [CRAN homepage](https://cran.rstudio.com/).

#### RStudio

Head over to the RStudio website's [download page](https://www.rstudio.com/products/rstudio/download/#download) and choose the appropriate installer for your platform.

### Gettings these files

Make sure you have [git](https://git-scm.com/) installed, then clone this repository and make your way to the `intro_to_tidyverse_f2017` directory like so:

```bash
$ git clone https://github.com/dataframing/ACM-NYU
$ cd ./ACM-NYU/intro_to_tidyverse_f2017
```

Also, let's save our working directory to our clipboard:

```bash
$ pwd | pbcopy
```

(Forgive me for mixing dashes and underscores — I am a sinner and heretic.)

### Running the examples

1. Open up RStudio (via command line or Applications -- whatever works!)
2. On the `terminal` pane, set your working directory by pasting what's in your clipboard, like so:
	
	```r
	setwd('paste your clipboard')
	```
	
3. Open up the file `tutorial.R` (with `File > Open File`) and let's get started!

---

Slide links: [kapow]()