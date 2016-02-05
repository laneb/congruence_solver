require "polynomial_interpreter"

RSpec.describe PolynomialInterpreter do
  describe "::read_congruence" do
    context "when input contains no '\='" do
      it "raises an ArgumentError" do
        not_congruence = "x^2 (mod 5)"
        expect {PolynomialInterpreter.read_congruence not_congruence}.to raise_error ArgumentError, "congruence invalid"
      end
    end

    context "when input contains no mod" do
      it "raises an ArgumentError" do
        not_congruence = "x^2 = 3"
        expect {PolynomialInterpreter.read_congruence not_congruence}.to raise_error ArgumentError, "congruence invalid"
      end
    end

    context "when input contains an invalid mod" do
      it "raises an ArgumentError" do
        not_congruence = "x = 5 (mod)"
        expect {PolynomialInterpreter.read_congruence not_congruence}.to raise_error ArgumentError, "congruence invalid"
      end
    end

    context "when lhs is empty" do
      it "raises an ArgumentError" do
        congruence = "= 3 (mod 4)"
        expect {PolynomialInterpreter.read_congruence congruence}.to raise_error ArgumentError, "lhs polynomial invalid"
      end
    end

    context "when lhs contains invalid characters" do
      it "raises an ArgumentError" do
        congruence = "x! = 3 (mod 5)"
        expect {PolynomialInterpreter.read_congruence congruence}.to raise_error ArgumentError, "lhs polynomial invalid"
      end
    end

    context "when lhs contains more than one distinct variables" do
      it "raises an ArgumentError" do
        congruence = "x^2 + y = 0 (mod 6)"
        expect {PolynomialInterpreter.read_congruence congruence}.to raise_error ArgumentError, "lhs polynomial invalid"
      end
    end

    context "when lhs contains negative power" do
      it "raises an ArgumentError" do
        congruence = "x^-1 = 2 (mod 35)"
        expect {PolynomialInterpreter.read_congruence congruence}.to raise_error ArgumentError, "lhs polynomial invalid"
      end
    end

    context "when rhs is empty" do
      it "raises an ArgumentError" do
        congruence = "x^3 = (mod 4)"
        expect {PolynomialInterpreter.read_congruence congruence}.to raise_error ArgumentError, "rhs polynomial invalid"
      end
    end

    context "when rhs contains invalid characters" do
      it "raises an ArgumentError" do
        congruence = "3 = x! (mod 5)"
        expect {PolynomialInterpreter.read_congruence congruence}.to raise_error ArgumentError, "rhs polynomial invalid"
      end
    end

    context "when rhs contains more than one distinct variables" do
      it "raises an ArgumentError" do
        congruence = "0 = x^2 + y (mod 6)"
        expect {PolynomialInterpreter.read_congruence congruence}.to raise_error ArgumentError, "rhs polynomial invalid"
      end
    end

    context "when rhs contains negative power" do
      it "raises an ArgumentError" do
        congruence = "2 = x^-1 (mod 35)"
        expect {PolynomialInterpreter.read_congruence congruence}.to raise_error ArgumentError, "rhs polynomial invalid"
      end
    end

    context "when input is a valid polynomial congruence" do
      it "formats congruence as a single polynomial congruent to 0" do
        congruence = "45x^5 + 5 + 3x ^6 + 5x^2 + x + 3x^5=x^9 + 9 x (mod 16)"
        expect( PolynomialInterpreter.read_congruence(congruence)).to eq [[-1, 0, 0, 3, 48, 0, 0, 5, -8, 5].reverse, 16]
      end
    end
  end
end