## Code Review

That was an interesting challenge in that the problem is quite overt. What I mean by that is that the way the problem is explained and the requirements are set out kind of suggests a particular sapproach - there is not too much deep decomposition required in order to arrive at a workable mental model. I think the reason for this is that the starting point of an alphabet is already a pretty well defined data structure and the way you need to shift forwards or backwards along this structure is already a fairly clear model within the problem description. Consequently there's not really a million different ways you could approach this.

There is some complexity - such as dealing with the case where you need to wrap around from the end of the alphabet back to the start and also in DRYing up the similarities in the encode and decode methods but this complexity is surfaced more in specific implementation details than within the overall structure of the program. 

This is borne out by the fact that most of the submitted solutions are pretty similar structurally and I think it's in the differences between the implementation details where the interest lies in comparing the various solutions.

In terms of the core functionality of the program there's two main problems to solve:

1. How to calculate the amount by which to 'shift' each letter along the alphabet in order to encode/ decode it
2. How to use this value in order to return the correct encoded/ decoded letter

### Calculating the distance

There's a couple of different approaches to this, with roughly a 50/50 split. 

  * Tak, David, Victoria and myself all define an `ALPHABET` constant which is an array of letters from `a` to `z`. The  'shift amount' is then calculated by identifying the index of the cipher key character within that array.

  * Tyler, Pete and the solution Kevin worked on in the live session all use the `String#ord` method - subtracting the `ord` value of `a` from the `ord` value of the cipher key character.

  [`String#ord`](http://ruby-doc.org/core-2.3.1/String.html#method-i-ord) 

  `ord -> integer`

  > Return the Integer ordinal of a one-character string.

  [Note: Pete's solution does define an alphabet in his `LETTERS` constant but he doesn't use this to calculate the shift distance.]

### Using the shift distance to encode/ decode

Again there are a couple of approaches here:

  * The solutions which calculated the shift distance by using a defined `ALPHABET` array, then use this shift distance either added to or subtracted from (depending on whether they are encoding or decoding) the index of the character to be encoded/ decoded and then use this new integer value as an index to obtain the appropriate character string object from the `ALPHABET` array. Victoria's is a little different in that she pre-defines the shift distance for each cipher key character in a separate array assigned to her `@coder` instance variable - the general approach/ mental model is effectively the same, however. 

  * The solutions that used the `String#ord` method use the shift value to calculate a new integer value in a similar way - by adding or subtracting from `ord` value of the character to be encoded. The resulting values then have `Integer#chr` called on them to return a single character string equivalent to the integer value's encoding.

There's obviously other differences in implementation between the various solutions but I thnk that these are the two main groupings in terms of approach.

Personally I prefer the approach of defining an alphabet structure within the program and working directly with that over the use of `ord` and `chr` as this feels like an additional layer of abstraction whereas using an alphabet structure makes the program feel more *self contained*. In terms of reaching a solution they are equally valid approaches, however.

### Other Observations

A lot of the other implementation differences were due to how the various solutions dealt with removing repetition within the code.

Tak keeps his `char_shift` and `char_unshift` methods completely separate (one is used by `encode` and the other by `decode`), and for a program of this size that probably isn't an issue. 

The other solutions all aim to have a single *cipher* method that can be called by either `encode` or `decode`, and there are various different approaches to this.

Victoria has a `run_coder` method which either uses the `ALPHABET` array (by default) or has a reversed version of `ALPHABET` passed to it as an argument when it is called within `decode`.

Tyler and David both use a combination of passing an operation in the form of a symbol as an argument to the cipher method and then using `send`. I think this is a nice approach. You can read more about `send` in the [Ruby Docs](https://ruby-doc.org/core-2.3.1/Object.html#method-i-send).

I also quite like Pete's idea of defining `ENCODE` and `DECODE` as positive or negative `1` and then passing these as the `direction` parameter of his `translate` and `shift_char` methods. This value is then multiplied by the `shift_amount` to turn it into a negative value for decoding.

Overall a pretty fun challenge that appears fairly obvious at first glance but has some hidden complexity when you dig into it.
