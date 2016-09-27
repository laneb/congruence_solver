# CongruenceSolver

CongruenceSolver is a gem for solving polynomial congruences. Should you ever need to solve polynomial congruences and have Ruby installed, this is the gem for you!

## Polynomial Congruences

Polynomial congruences are the central topic of most elementary number theory and abstract algebra curricula. A [congruence](https://en.wikipedia.org/wiki/Modular_equation) is an [equivalence relation](https://en.wikipedia.org/wiki/Equivalence_relation) arising from [modular arithmetic](https://en.wikipedia.org/wiki/Modular_arithmetic) (or "clock arithmetic"). For example, the idea "5 hours past 8 is 1" is expressed in the congruence <code>8 + 5 = 1 mod 12</code>. A polynomial congruence is simply a congruence involving a polynomial e.g. <code>x + 6 = 1 mod 15</code> or <code>x<sup>3</sup> - x<sup>2</sup> = 0 mod 39.</code>

The problem of solving a system of congruences is to find all inputs satisfying the congruence, much like solving a system of equations. Elementary number theory develops tools like [Hensel Lifting](https://en.wikipedia.org/wiki/Hensel%27s_lemma#Hensel_Lifting) for solving polynomial congruences and the [Chinese Remainder Theorem](https://en.wikipedia.org/wiki/Chinese_remainder_theorem) systems of polynomial congruences.

## Installation

With [RubyGems](https://rubygems.org/) on your machine, installation is as easy as 
```shell
gem install congruence_solver
```

You may also install via [bundler](http://bundler.io/), by adding this line to your application's Gemfile:

```ruby
gem 'congruence_solver'
```

and executing

```shell
$ bundle
```

in the project directory.

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

## Development

After checking out the repo, run `bundle install` to install dependencies and `bundle exec rake update_ext` to pull and compile the extension. Then, run `bundle exec rake spec` to run the tests, or `bundle exec rake bench` to run the benchmark. To build and install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/laneb/congruence_solver.

