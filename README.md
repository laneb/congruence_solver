# CongruenceSolver

CongruenceSolver is a gem for solving polynomial congruences. Should you ever need to solve polynomial congruences and have Ruby installed, this is the gem for you!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'congruence_solver'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install congruence_solver

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

