## Code Review

That was an interesting weekly challenge with a couple of contrasting problems to solve. In the opening post of this thread Kevin suggested that the key to both these problems might be on the data-structure(s) chosen initially; I think that was definitely proved true of the [Scrabble Score](https://launchschool.com/exercises/affefe14) problem, but less so of [Kindergarten Garden](https://launchschool.com/exercises/d0867e33)

### Scrabble Score

This was definitely the more straightforward of the two problems and as mentioned above the processing logic of the solution depended very much on data structure chosen at the outset to map the letters to their scores. In this respect I really like Tyler's and Pete's solutions which use a case statement to do the mapping; I think this is a great option for a number of reasons:

* It automatically suggests grouping of letters by score as opposed to 1-to-1 mapping (like some of the hash solutions)
* It allows the use of an `else` clause for a `0` score which removes the requirement to do some kind of transformation of the input and/ or use a guard clause (e.g. in the `score` method) to deal with the `nil` and empty string edge cases
* It encapsulates the data and some of the logic in one place which means that the `score` method can be kept relatively simple

The combination of the case statement for the data and the resulting simplicity of the `score` method makes the whole solution extremely readable.

Other than a few variable names Tyler's and Pete's solutions were pretty much identical and there isn't really anything to choose between them. 

If I was being super-picky I'd probably say that I prefer the fact that Pete works directly with the `@word` instance variable in his `score` method over Tyler's use of an `attr_reader`.

The only other real difference between their solutions was that Pete calls `each_char` on `@word` and Tyler calls `chars`. 

`each_char` returns an Enumerator object:
```ruby
'hello'.each_char # => #<Enumerator: "hello":each_char>
```
and `chars` returns an Array object:
```ruby
'hello'.chars # => ["h", "e", "l", "l", "o"]
```
This choice doesn't affect the working of the code but for development/ debugging purposes I'd probably prefer `chars` here as it would allow me to see exactly what I'm working with. Not sure which, if either, would be considered best-practice though.

As stated, these are really minor differences.

Of the non-case solutions I like David Renz'. This is kind of the opposite end of the spectrum with regards to the data in that there is no grouping and the data structure is separate from the processing logic. The use of 1-to-1 mapping in the hash combined with the use of `reduce` early on in the `score` method (a lot of the other solutions, including mine, used `reduce`/`inject` at the end of the process) leads to a simple and very readable solution. I would probably prefer a guard clause in the `score` method over what David has done to deal with invalid input in the `initalize` method, but this is really just personal preference.

* =1st : Pete Hanson, Tyler Lippert
* 3rd: David Renz
