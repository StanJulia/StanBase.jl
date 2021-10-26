import Base: show

"""

# RandomSeed

Random number generator seed value

### Method
```julia
RandomSeed(;seed=-1)
```
### Optional arguments
```julia
* `seed::Int`           : Starting seed value
```
""" 
mutable struct RandomSeed
  seed::Int64
end
RandomSeed(;seed::Number=-1) = RandomSeed(seed)

"""

# Init

Default bound for parameter initial value interval (if not found in init file)

### Method
```julia
Init(;bound=2)
```
### Optional arguments
```julia
* `bound::Number`           : Set interval to [-bound, bound]
```
""" 
mutable struct Init
  bound::Int64
end
Init(;bound::Int64=2) = Init(bound)

"""

# Output

Default settings for output portion in cmdstan command

### Method
```julia
Output(;refresh=100)
```
### Optional arguments
```julia
* `refresh::Int64`                     : Output refresh rate
```
""" 
mutable struct Output
  refresh::Int64
end
Output(;refresh=100) = Output(refresh)

