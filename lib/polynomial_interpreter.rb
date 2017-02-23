class PolynomialInterpreter
  module Errors
    POLYNOMIAL_INVALID = ArgumentError.new "polynomial invalid"
    CONGRUENCE_INVALID = ArgumentError.new "congruence invalid"
    LHS_POLYNOMIAL_INVALID = ArgumentError.new "lhs polynomial invalid"
    RHS_POLYNOMIAL_INVALID = ArgumentError.new "rhs polynomial invalid"
    MOD_INVALID = ArgumentError.new "mod invalid"
  end


  def self.read_congruence(input_congruence)
    match_data = input_congruence.match(/^(.*)=(.*) +(?:mod +(.*)|\(mod +(.*)\))$/)

    if match_data.nil?
      raise Errors::CONGRUENCE_INVALID
    end

    lhs = match_data[1]
    rhs = match_data[2]
    mod = match_data[3] || match_data[4]

    begin
      lh_coeffs = read_coeffs(lhs.gsub(" ", ""))
    rescue ArgumentError
        raise Errors::LHS_POLYNOMIAL_INVALID
    end

    begin
      rh_coeffs = read_coeffs(rhs.gsub(" ", ""))
    rescue ArgumentError
        raise Errors::RHS_POLYNOMIAL_INVALID
    end

    if mod !~ /\d+/ or mod.to_i < 2
      raise Errors::MOD_INVALID
    end

    0.upto rh_coeffs.length-1 do |idx|
      unless rh_coeffs[idx].nil?
        lh_coeffs[idx] ||= 0
        lh_coeffs[idx] -= rh_coeffs[idx]
      end
    end

    [lh_coeffs, mod.to_i]
  end

  def self.read_coeffs(input_polynomial)
    if input_polynomial == ""
      raise Errors::POLYNOMIAL_INVALID
    end

    last_var = nil
    coeffs = Array.new

    unless input_polynomial[0].match /[-+]/
      input_polynomial = "+" + input_polynomial
    end

    while input_polynomial.length > 0 do
      op = input_polynomial.slice!(0)
      unless op =~ /[-+]/
        raise Errors::POLYNOMIAL_INVALID
      end

      input_polynomial.slice!(/^(\d+)\*?/)
      match_data_coe = Regexp.last_match

      input_polynomial.slice!(/^([a-zA-Z])(?:\^(\d+))?/)
      match_data_exp = Regexp.last_match

      if match_data_coe.nil? and match_data_exp.nil?
        raise Errors::POLYNOMIAL_INVALID
      else
        if match_data_exp.nil?
          coe = match_data_coe[1].to_i
          exp = 0
        else
          unless last_var.nil? or last_var == match_data_exp[1]
              raise Errors::POLYNOMIAL_INVALID
          end

          last_var = match_data_exp[1]

          if match_data_coe.nil?
            coe = 1
          else
            coe = match_data_coe[1].to_i
          end

          if match_data_exp[2].nil?
              exp = 1
          else
            exp = match_data_exp[2].to_i
          end
        end
      end

      coeffs[exp] ||= 0
      if op == "-"
        coeffs[exp] -= coe.to_i
      else
        coeffs[exp] += coe.to_i
      end
    end

    0.upto(coeffs.length-1) do |idx|
      coeffs[idx] ||= 0
    end

    coeffs
  end
end
