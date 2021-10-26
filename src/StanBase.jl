"""

Helper infrastructure package to compile and sample models using Stan's `cmdstan`.
Not really intended to be called directly by a user.

# Extended help

Exports:
```Julia
* `CMDSTAN_HOME`                       : Fields common to all CmdStanModels
* `@shared_fields_stanmodels`          : Fields common to all CmdStanModels
* `CmdStanModels`                      : Supertype of CmdStanModels, see ?CmdStanModels
* `StanModelError`                     : Exception error on cmdstan compilation failure
* `HelpModel`                          : Simplests of the CmdStanModels
* `cmdline`                            : Inital portion of the cmdstan cammand line
* `stan_help`                          : Alias for calling stan_sample with a HelpModel
* `stan_sample`                        : Generic call to cmdstan, dispatched on CmdStanModel
* `read_summary`                       : Read the cmdstan summary .csv file
* `stan_summary`                       : Create the cmdstan summary .csv file
* `get_cmdstan_home``                  : Directory with cmdstan binaries
* `set_cmdstan_home!``                 : Update the cmdstan directory
* `findall`                            : Defined only for Julia versions < 1.3
```
"""
module StanBase

using DocStringExtensions: FIELDS, SIGNATURES, TYPEDEF
using Unicode, DelimitedFiles, Distributed
using Parameters

using StanDump

include("common/common_definitions.jl")
include("common/top_level_types.jl")
include("common/par.jl")
include("common/stan_run.jl")
include("common/update_model_file.jl")

include("stanmodel/HelpModel.jl")

include("stanrun/cmdline.jl")

"""
The directory which contains the cmdstan executables such as `bin/stanc` and
`bin/stansummary`. 

# Extended help

Inferred from the environment variable `JULIA_CMDSTAN_HOME` or `ENV["JULIA_CMDSTAN_HOME"]`
when available.

If these are not available, use `set_cmdstan_home!` to set the value of CMDSTAN_HOME.

Example: `set_cmdstan_home!(homedir() * "/Projects/Stan/cmdstan/")`

Executing `versioninfo()` will display the value of `JULIA_CMDSTAN_HOME` if defined.
"""
CMDSTAN_HOME=""

function __init__()
  global CMDSTAN_HOME = if isdefined(Main, :JULIA_CMDSTAN_HOME)
    Main.JULIA_CMDSTAN_HOME
  elseif haskey(ENV, "JULIA_CMDSTAN_HOME")
    ENV["JULIA_CMDSTAN_HOME"]
  elseif haskey(ENV, "CMDSTAN_HOME")
    ENV["CMDSTAN_HOME"]
  else
    @warn("Environment variable CMDSTAN_HOME not set. Use set_cmdstan_home!.")
    ""
  end
end

"""

Alias for stan_sample(helpmodel,...)

# Extended help

see ?HelpModel
see ?stan_sample
"""
stan_help = stan_run

export
  HelpModel,
  stan_help,
  get_cmdstan_home,
  set_cmdstan_home!

end # module
