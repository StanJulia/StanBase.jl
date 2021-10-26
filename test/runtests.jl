using StanBase
using Test

if haskey(ENV, "JULIA_CMDSTAN_HOME")

  stan_prog = "
  data { 
    int<lower=1> N; 
    int<lower=0,upper=1> y[N];
    real empty[0];
  } 
  parameters {
    real<lower=0,upper=1> theta;
  } 
  model {
    theta ~ beta(1,1);
    y ~ bernoulli(theta);
  }
  ";


  println("\nRunning StanBase.jl tests")

  @testset "Basic HelpModel" begin
    
    sm = HelpModel( "help", stan_prog)

    rc = stan_help(sm)

    if success(rc)
      println()
      @test sm.method == StanBase.Help(:sample)
      @test sm.num_chains == 4
    end

  end
else
  println("\nJULIA_CMDSTAN_HOME not set. Skipping tests")
end
