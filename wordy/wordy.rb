# wordy.rb

- WordProblem class takes a string as an argument to initialize method
  - The string comprises of:
    - Integers in String format `'1'`, `'2'`, etc..
    - Operations words in String format `'plus'`, `'minus'`, `'multiplied by'`, `'divided by'`
      - Operations such as `'cubed'` are not valid
    - A string should have at least two numbers and one valid operation to be a valid WordProblem
      - An invalid WordProblem should return an ArgumentError
    - Operations are carried out sequentially (i.e. normal operation order is not respected)
- WordProblem class has a `answer` instance method which returns an integer value of the answer
