	
class PolynomialInterpreter
	BLANK_POLYNOMIAL_MSG = "polynomial blank"
	INVALID_POLYNOMIAL_MSG = "polynomial invalid"

	def self.read_congruence(input_congruence)
		input_congruence = input_congruence.gsub(" ", "")
		match_data = input_congruence.match(/^(.*)=(.*)(?:mod(\d+)|\(mod(\d+)\))$/)

		if match_data.nil? then raise ArgumentError, "not a congruence" end

		lhs = match_data[1]
		rhs = match_data[2]
		mod = match_data[3] || match_data[4]

		begin
			lh_coeffs = read_coeffs(lhs)
		rescue ArgumentError => e
			if e.message == BLANK_POLYNOMIAL_MSG
				raise ArgumentError, "LHS #{BLANK_POLYNOMIAL_MSG}"
			elsif e.message == INVALID_POLYNOMIAL_MSG
				raise ArgumentError, "LHS #{INVALID_POLYNOMIAL_MSG}"
			else
				raise e
			end
		end

		begin
			rh_coeffs = read_coeffs(rhs)
		rescue ArgumentError => e
			if e.message == BLANK_POLYNOMIAL_MSG
				raise ArgumentError, "RHS #{BLANK_POLYNOMIAL_MSG}"
			elsif e.message == INVALID_POLYNOMIAL_MSG
				raise ArgumentError, "RHS #{INVALID_POLYNOMIAL_MSG}"
			else
				raise e
			end
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
		if(input_polynomial == "") then raise ArgumentError, BLANK_POLYNOMIAL_MSG end

		last_var = nil
		coeffs = Array.new

		loop do
			input_polynomial.slice!(/^(\d+)/)
			match_data_coe = Regexp.last_match

			input_polynomial.slice!(/^([a-zA-Z])(?:\^(\d+))?/)
			match_data_exp = Regexp.last_match

			if match_data_coe.nil? and match_data_exp.nil? 
				raise ArgumentError, INVALID_POLYNOMIAL_MSG 
			else 
				if match_data_exp.nil?
					coe = match_data_coe[1].to_i
					exp = 0
				else
					unless last_var.nil? or last_var == match_data_exp[1]
							raise ArgumentError, INVALID_POLYNOMIAL_MSG
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
			coeffs[exp] += coe.to_i

			break if input_polynomial.length == 0

			op = input_polynomial.slice!(0)

			unless op.match /[-+]/
				raise ArgumentError, INVALID_POLYNOMIAL_MSG
			end
		end

		0.upto(coeffs.length-1) do |idx|
			coeffs[idx] ||= 0
		end

		coeffs
	end
end