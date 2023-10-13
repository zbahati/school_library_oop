class Solver
  def factorial(n)
    if n < 0
      raise ArgumentError 'Input should be non negative numbers'
    end
    result = 1

    (1..n).each do |i|
      result *= i
    end
    result
  end
end