class Solver
  def factorial(val)
    if val.negative?
      raise ArgumentError, 'Input should be non negative number'
    end

    result = 1

    (1..val).each do |i|
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
