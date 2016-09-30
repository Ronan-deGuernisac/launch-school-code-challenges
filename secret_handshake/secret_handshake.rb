# secret_handshake.rb

1. The initialize method of the class should take one argument
  * The argument can be either an integer or a string
  * If the argument is an integer it should be convert to a string representing the
  binary value of that integer
  * If the argument is a string it should be validated to ensure that it is a validated
  binary number - if invalid the number '00000000' should be assigned
  * We are only interested in the last five digits of the binary number
2. The class requires a `commands` instance method
  * `commands` should return an array of strings equivalent to each operation
  * Iterate through the binary number and run the operations in the appropriate order
