# StanBase v4.12.4

| **Project Status**          |  **Build Status** |
|:---------------------------:|:-----------------:|
|![][project-status-img] | ![][CI-build] |

[docs-dev-img]: https://img.shields.io/badge/docs-dev-blue.svg
[docs-dev-url]: https://stanjulia.github.io/StanBase.jl/latest

[docs-stable-img]: https://img.shields.io/badge/docs-stable-blue.svg
[docs-stable-url]: https://stanjulia.github.io/StanBase.jl/stable

[CI-build]: https://github.com/stanjulia/StanBase.jl/workflows/CI/badge.svg?branch=master

[issues-url]: https://github.com/stanjulia/StanBase.jl/issues

[project-status-img]: https://img.shields.io/badge/lifecycle-stable-green.svg

## Introduction

This package contains common components and methods for several packages wrapping Stan's `cmdstan` executable. 

The actual Stan methods supported, e.g. `stan_sample()`,  `stan_optimize()`, etc., are in StanSample.jl, StanOptimize.jl, StanVariational.jl, StanDiagnose.jl and `generated_quantities` (included in StanSample.jl). 

A new package, DiffEqBayesStan.jl is available to focus on DifferentialEquations and Stan.

Another package, StanQuap.jl, provides a quadratic approximation using StanOptimize.jl and StanSample.jl which I have used in the early chapters of [StatisticalRethinking](https://github.com/StatisticalRethinkingJulia).

These six application packages support all features and options currently available in the `cmdstan` executable.

## Installation

This package is registered. Install it with:
```Julia
pkg> add StanBase
```
although the intention is that users of Stan's `cmdstan` executable will never have to install StanBase.jl, they can simply install any of the application packages listed [here](https://github.com/StanJulia). 

This and all the method packages need a working [cmdstan](https://mc-stan.org/users/interfaces/cmdstan.html) installation, the path of which you should specify in an evironment variable `CMDSTAN`, e.g. in your `~/.julia/config/startup.jl` have a line like:
```julia
ENV["CMDSTAN"] = expanduser("~/.../cmdstan/") # replace with your path
```
This package is structured somewhat similar to Tamas Papp's [StanRun.jl](https://github.com/tpapp/StanRun.jl) package. 

## Versions

Martrix input data is not handled properly in v6.4, please use v6.5

StanBase.jl v4 supports Stan.jl v9 and StanSample v6 which by default use C++ level threads (and chains). This has major consequences for StanSample.jl and Stan.jl (explained in the documentation of Stan.jl v9 and in the on-line help in StanSample.jl v6). As such StanBase.jl v4 is a breaking update.

StanBase.jl versions < v4.0.0 used StanDump.jl to create data.R and init.R files. It is no longer clear if .R files will be supported in future version of cmdstan. Certainly with cmdstan-2.35.0 I have seen error messages when using init.R files. Hence version 4 uses by default JSON.jl for this purpose. I have added a positional `use_json=true` argument to e.g. stan_sample().

StanBase v4.7.0 drops support for creating R files (Thanks to Andrew Radcliffe).


