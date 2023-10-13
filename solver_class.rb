class Solver
  def factorial(number)
    raise ArgumentError, 'Input should be a non-negative number' if number.negative?

    result = 1

    (1..number).each do |i|
      result *= i
    end
    result
  end

  def reverse(word)
    word.reverse
  end

  def fuzzbuzz(number)
    if (number % 5).zero? && (number % 3).zero?
      'fuzzbuzz'
    elsif (number % 5).zero?
      'buzz'
    elsif (number % 3).zero?
      'fuzz'
    else
      number.to_i
    end
  end
end
