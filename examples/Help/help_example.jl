using StanBase

ProjDir = @__DIR__

sm = HelpModel()
rc = stan_help(sm; "sample help")

if success(rc)
	run(`cat $(sm.log_file[1])`)
end
