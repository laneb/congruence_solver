require "congruence_solver"

RSpec.describe CongruenceSolver do
  describe "::lift" do
    it "expects 3 arguments" do
      expect {CongruenceSolver.lift()}.to raise_error ArgumentError
      expect {CongruenceSolver.lift(0)}.to raise_error ArgumentError
      expect {CongruenceSolver.lift([1,2], 3)}.not_to raise_error
      expect {CongruenceSolver.lift([1], [1], nil)}.to raise_error ArgumentError
    end


    it "solves individual polynomial congruences defined by their coefficients and mod" do
      coeffs = [-1, 0, 4]
      mod = 5
      expect(CongruenceSolver.lift(coeffs, mod).sort).to eq [2, 3]

      coeffs = [-3, 4, 9]
      mod = 49
      expect(CongruenceSolver.lift(coeffs, mod).sort).to eq []

      coeffs = [1, -4, 4]
      mod = 5104
      expect(CongruenceSolver.lift(coeffs, mod).sort).to eq []

      coeffs = [4, -4, 1]
      mod = 5104
      expect(CongruenceSolver.lift(coeffs, mod).sort).to eq [2, 1278, 2554, 3830]

      coeffs = Array.new(500, 0)
      coeffs[0] = -1
      coeffs[500] = 1
      mod = 15
      expect(CongruenceSolver.lift(coeffs, mod).sort).to eq [1, 2, 4, 7, 8, 11, 13, 14]
    end

  end
end