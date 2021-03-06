# CongruenceSolver

CongruenceSolver is a gem for solving polynomial congruences. Should you ever need to solve polynomial congruences, this is the gem for you!

## Polynomial Congruences

Polynomial congruences are the central topic of most elementary number theory and abstract algebra curricula. Similar to an equation, a [congruence](https://en.wikipedia.org/wiki/Modular_equation) is an [equivalence relation](https://en.wikipedia.org/wiki/Equivalence_relation) arising from [modular arithmetic](https://en.wikipedia.org/wiki/Modular_arithmetic) (also knowsn as "clock arithmetic"). For example, the idea "5 hours past 8 is 1" is expressed in the congruence ```8 + 5 = 1 mod 12```. A polynomial congruence is simply a congruence involving a polynomial, like ```x + 5 = 1 mod 12```. The problem of solving a congruence is to find all inputs satisfying the congruence, much like solving an equation (in this case, ```x = 8```). Generally speaking, congruences become more difficult to solve as the degree of the polynomial and the modulus grow. Elementary number theory develops tools like [Hensel Lifting](https://en.wikipedia.org/wiki/Hensel%27s_lemma#Hensel_Lifting) for solving polynomial congruences and the [Chinese Remainder Theorem](https://en.wikipedia.org/wiki/Chinese_remainder_theorem) for solving systems of polynomial congruences. This gem leverages these methods as implemented in C in [congruence_solver](https://github.com/laneb/congruence_solver).

## Installation

With [RubyGems](https://rubygems.org/) on your machine, the basic installation is as easy as
```shell
gem install congruence_solver
```

However, if you would like to use this gem *with OpenMP support*, you will need to make sure that the Ruby binary in your path was compiled with a compiler that supports OpenMP - gcc 4.2 or later will work. Determine the compiler option needed to add OpenMP support - for gcc, this is -fopenmp. To install use  
```shell
gem install congruence_solver --  --openmp=_MY_OPTION_
```
For gcc, this would be
```shell
gem install congruence_solver -- --openmp=-fopenmp
```

To include this gem in a project via bundler, add congruence_solver to your Gemfile and run
```
bundle install
```
To include OpenMP support when installing via bundler, before running `bundle install` run
```
bundle config build.congruence_solver --openmp=_MY_OPTION_
```

## Usage

To solve a polynomial congruence at the command line, simply invoke `csolve` and then enter the congruence at the prompt.

```
csolve
Congruence to solve:
x^2 + 2x + 1 = x^3 + 3x^5 mod 49
(0) 1
(1) 8
(2) 15
(3) 22
(4) 26
(5) 29
(6) 36
(7) 43
```

To use the CongruenceSolver in a Ruby program, use CongruenceSolve::solve_congruence(coeffs, mod), where coeffs is the ascending list of coefficients of the polynomial (congruent to 0) and mod is the modulus of the congruence.

```
#solve -3x^5 - x^3 + x^2 + 2x + 1 = 0 mod 49
coeffs = [1, 2, 1, 1, 0, 3]
mod = 49
CongruenceSolver.solve_congruence(coeffs, mod).sort  #=> [1, 8, 15, 22, 26, 29, 36, 43]
```

## Limitations

What are the limitations on the size of the numbers, you ask? CongruenceSolver can solve any congruence with a 16 bit degree that 32 bit coefficients and modulus. Of course, Ruby's Bignum can manage arbitrarily large integers without overflow, but the extension that powers CongruenceSolver has limitations to maintain speed and simplicity.

## Development

First, install bundler (`gem install bundler`). Then install this project's dependencies with `bundle install`. Use `bundle exec rake update_ext` to pull and compile the extension. Use `bundle exec rake spec` to run the tests and `bundle exec rake bench` to run the benchmark.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/laneb/congruence_solver.
