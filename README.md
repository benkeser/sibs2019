# SIBS 2019 Intro to ML Materials

**Authors:** [David Benkeser](https://www.github.com/benkeser/)

-----

## Description

`sibs2019` contains all code used to create the Docker image and 
run basic machine learning analyses on real and simulated data. 

-----

## Usage

This GitHub repository contains the source code needed to build the
docker image that was used in class. The built image is also available on
[DockerHub]
(https://cloud.docker.com/u/dbenkeser/repository/docker/dbenkeser/sibs2019).
The `R` code can be found in the `/R` directory, while `.RData` files are in
the `/data` directory. 

To run the docker image on a local machine (i.e., to obtain the same R Studio
environment that was demonstrated in class), you need to [download docker]
(https://docs.docker.com/docker-for-windows/install/) to your local machine. 

From the command line you would execute the command.

``` bash
docker run -e PASSWORD=sosecret! -p 8787:8787 -d dbenkeser/sibs2019:latest
```

Then open a browser window and navigate to `localhost:8787`, where you will be
prompted to login to R Studio using the `PASSWORD` created above (user is
`rstudio`). 

In the container relevant `R` scripts can be found in `/home/lib` and relevant
data in `/home/data`. The "secret" outcomes data are in `/home/secret`.

## Issues

If you encounter any bugs or can't remember how to run the container you can
[file an issue](https://github.com/benkeser/sibs2019/issues).

-----

## License

© 2019- David Benkeser

The contents of this repository are distributed under the MIT license:

    The MIT License (MIT)
    
    Copyright (c) 2019 David C. Benkeser
    
    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
