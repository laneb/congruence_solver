
def polynomial_to_s(coeffs)
    polynomial = ""
    is_first_term = true

    coeffs.reverse.each_with_index do |coe, idx|
      exp = coeffs.length - idx - 1
      if coe != 0
        if is_first_term
          is_first_term = false
        else
          if coe < 0
            polynomial << " - "
          else
            polynomial << " + "
          end
        end

        if coe.abs > 1 or (coe.abs == 1 and exp < 2)
          polynomial << coe.abs.to_s
        end

        if exp > 0
          polynomial << "x"
          if exp > 1
            polynomial << "^#{exp}"
          end
        end
      end
    end

    polynomial
end