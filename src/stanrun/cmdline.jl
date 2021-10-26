"""

Recursively parse the model struct to build the first part of the command line. 

$(SIGNATURES)

# Extended help

### Method
```julia
cmdline(model)
```

### Required arguments
```julia
* `model::CmdStanModels`               : Subtype object of CmdStanModels
```

### Returns
```julia
* `cmd`                                : Method depended portion of the cmd
```

Internal, not exported.
"""
function cmdline(model::HelpModel, id)
  
  #=
  `executable_path sample help`
  =#
  
  cmd = ``
  if isa(model, HelpModel)
    # Inserts the executable for unix and windows
    cmd = `$(model.exec_path)`

    # `help` specific portion of the model
    cmd = `$cmd help-all`
  end
  
  cmd
  
end

