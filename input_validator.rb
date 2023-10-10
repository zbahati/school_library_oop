class InputValidator
  def self.validate_integer_input(input)
    Integer(input)
  rescue ArgumentError
    false
  end

  def self.validate_date_input(date)
    /^\d{4}-\d{2}-\d{2}$/.match?(date)
  end
end
