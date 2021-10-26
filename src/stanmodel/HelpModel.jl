import Base.show

mutable struct HelpModel <: CmdStanModels
    tmpdir::AbstractString;            # Hold all created files
    log_file::AbstractString;          # Capture output help command
    topic::AbstractString;             # Help (sub-)topic
end

function HelpModel(tmpdir=mktempdir())
  
  !isdir(tmpdir) && mkdir(tmpdir)
  
  output_base = joinpath(tmpdir, "Help")
  exec_path = executable_path(output_base)
  cmdstan_home = get_cmdstan_home()

  error_output = IOBuffer()
  is_ok = cd(cmdstan_home) do
      success(pipeline(`make -f $(cmdstan_home)/makefile -C $(cmdstan_home) $(exec_path)`;
                       stderr = error_output))
  end
  if !is_ok
      throw(StanModelError("HelpModel", String(take!(error_output))))
  end
  
  HelpModel(tmpdir, "", "help-all")
end

function help_model_show(io::IO, m, compact::Bool)
  println(io, "  tmpdir =                  \"$(m.tmpdir)\"")
  println(io, "  topic =                  \"$(m.topic)\"")
end

show(io::IO, m::HelpModel) = help_model_show(io, m, false)
