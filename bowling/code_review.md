# Code Review

Kevin mentioned in the live session that if this coding challenge was an interview/ assessment question then it would likely be a take-home exercise where we would be expected to code a solution to the problem in our own time and then explain our reasoning for certain design decisions in the interview/ assessment. Based on that comment I thought it might be interesting this week, rather than review each other's submissions, to review our own, explain our design decisions, trade-offs, and maybe identify parts of our code that we would refactor in retrospect.

### Storing the Data

One of the main design decisions to be made is the structure used to store the value for each roll. Kevin outlined early on in the live session that there were three main options here:

* A flat array `[1, 5, 7, 3, 4, 6]`
* A nested array of 'frames' `[[1, 5], [7, 3], [4, 6]]`
* An array of 'frame objects' `[frame1, frame2, frame3]`

There are probably other options here such as a hash or nested hash but these three are the most immediately apparent. I decided early on to use a flat array. The reason for this was that looking at the test suite there were two methods that we needed to implement - `roll` (which was passed an argument for the number of pins knocked down in that roll) and `score` (which would return the overall score of the game). Since `score` only needed to be called when the game was complete (i.e. all the balls had been rolled) I felt that adding each roll to a flat array, and then manipulating that array later on in my `score` method, would allow me to keep much of the processing logic in one place (the `score` method) rather than splitting it across a couple of methods or even abstracting some of it to other classes. It also allows for the `roll` method to be kept relatively simple.

I believe that this improves the overall readability of the program, though it probably isn't the most Object Oriented approach. I should also add that this design decision was taken purely within the context of the exercise; if this was a real world application there would be other considerations - e.g. even though returning a score 'in-game' is not part of the initial specification this might be a feature we would want to add in the future and so in this case a different choice of data structure might be more appropriate.

I assign the array object to the `@rolls` instance variable in my `initialize` method and instantiate that array by calling `new` on `Array` class with an argument of `24` passed to it (this value is equivalent to the maximum number of 'roll slots' for a perfect game):

```ruby
@rolls = Array.new(24)
```

This creates an array of 24 `nil` objects. I took this approach because initially I thought this would allow me identify the index of the '`'current throw'`' more easily (I do this using the `next_empty` method) but ultimately I only really use this index in one place (in my `open_rolls_over?` which supports the `'Pin count exceeds pins on the lane'` error) and so in retrospect I would refactor here to use an empty array. This would remove the necessity for the `next_empty` method as I could simply push the value for each new roll to the empty array. It would also allow me to simplify a couple of other parts of the program (e.g. in my `score` method, I would no longer need to call `compact` on the `@rolls` array prior to calling `each_slice`).

As well as the `@rolls` array I also assign an emtpy array to another instance variable `@frames` to be used later by my `score` method.

### The `roll` Method

As mentioned above, using a flat array to store the roll values allows for keeping the `roll` method fairly simple. There's only really two main things happening here:

* The value for the current roll being added to the next 'empty slot' in the array
* An 'X' being added to the 'slot' after that if the current roll is `10`

The reasoning for this second part is that even though my `@rolls` array is not structured as individual frames I knew that I would need to convert it into frames when calculating the score and so wanted to keep the structure consistent so that the initial coversion of each frame would be the same regardless of whether one ball was thrown in that frame (a strike) or two balls were thrown (a spare or open frame). In order to achieve this I needed to add an object to the `@rolls` array to account for the 'missing' ball from a frame where a strike is rolled. The choice of filling object is fairly inconsequential but I chose a `'X'` string as this is consistent with a 'real world' identification of a strike in bowling.

There's a trade-off here in that adding the `'X'` allows me to keep a consistency in the structure and therefore supports simplicity in other elements of the program (such as slicing the array into frames) but also adds another element to deal with - i.e. I need to add some logic to remove the `'X'`'s when calculating the scores for strike frames. Given that strike frames will already require their own scoring logic in any case (and so any additional logic around dealing with the `'X'`'s can be incorporated into this), I feel that the trade-off here is an acceptable one.

In retrospect I'd refactor this method to move the validation checks to their own methods. This, along with the additional refactoring as a result of initializing the `@rolls` array as an empty array, would simplify the method even further:

```ruby
def roll(pins)
  validate_roll_value(pins)
  validate_frame_value(pins)
  validate_game_status

  @rolls << pins
  @rolls << 'X' if pins == 10
end
```

### The `score` Method

The `score` method is the part of the program where all the 'heavy lifting' is done. This is as a result of keeping the inital data structure, and thus the `roll` method, relatively simple. This trade off means that more work now has to be done to manipulate the data, but since this is effectively being done in one place(helper methods aside) it's easier to parse the logic of the method and therefore improves the readability of the code.

Aside from the validation, there are three main elements to the method:

* Populating the `@frames` instance variable from the values in the `@scores` instance variable
* Creating a `frame_scores` variable which is assigned to an array of `Integer` values for each frame mapped from the `@frames` array
* Calculating the total score of all the frames

The first and third parts of this are fairly simple, and could actually be simplified further. I can remove the call to `compact` on @rolls from the first part since `@rolls` should no longer contain any `nil` objects. During my review I have also realised that it is not necessary to call `flatten` on `frame_scores` since this is already a flat array. In fact I can remove this line altogether if I refactor the second part.

Although I didn't know this when initially implementing the solution, having further researched the `Enumerable#reduce` method I've found that it is actually possible to chain `reduce` to `each_with_index` and so I can actually combine the second and third parts like so:

```ruby
@frames.each_with_index.reduce(0) do |sum, (_, frame_index)|
  sum + frame_score(frame_index)
end
```

[As a side note to this method, if I ever wanted to amend the `roll` method to push the scores to sub-arrays within `@frames` instead of the `@rolls` flat array, it wouldn't take too much refactoring of `score` to support this.]

#### The `frame_score` method

Whichever way I decide to implement the `score` method (whether I use `map` or `reduce`) I still need to call on the `frame_score` helper method in order to calculate the scores of the individual frames. It's actually a pretty simple method - just a conditional (in the form of a case statement) with the various branches representing the different scoring cases outlined in the problem description, with the addition of a `fill_balls?` case (since I am treating all 'frames' as identical within my data structure I need to account for 'frames' 11 & 12 which are used to capture any possible 'fill ball' rolls and so do not actually have a score in themselves).

The choice to use a case statement here is fairly arbitrary - this could just as easily be if/else - and so is simply down to personal preference. Other than the case for strikes, the calculations within each case are fairly simple - fills balls get a `0`, spares frames are a total of that frame's values plus the first value from the next frame, and open frames (covered by the `else` case) are simply the total of that frame's values.

The method relies on other helper methods - `fill_balls?`, `strike?` and `spare?` (which all return a boolean) - to determine which conditional branch to apply.

#### The `strike_score` method

The logic for the `strike_score` case is extracted to another helper method. Although this is a further abstraction from the original strating point in the `score` method, I felt that this was preferable to leaving this logic within the case statement as it waould be easier for anyone reading the code to parse if extracted in this way.

The logic behind the method is again fairly simple. It combines the current frame and the two subsequent frames into an array, flattens it, rejects any `'X'` objects and then totals the first three of the remaining values to calculate the overall score for the strike. This covers the possibility of a single strike followed by two 'standard' rolls, two consecutive strikes followed by a standard roll, or three consecutive strikes.

```ruby
def strike_score(frame, frame_index)
  [
    frame,
    @frames[frame_index + 1],
    @frames[frame_index + 2]
  ].flatten.reject { |value| value == 'X' }.slice(0, 3).reduce(:+)
end
```

### Other Refactoring

Having reviewed the program there are a few other things that I would refactor.

* Making the `spare?` method more robust. 
```ruby
def spare?(frame)
  frame.reduce(:+) == 10
end
```
At the moment it would raise an error if called on a strike frame:
```ruby
[10, 'X'].reduce(:+) == 10 # => TypeError: String can't be coerced into Fixnum
```
the only reason it isn't called on a strike frame currently is due to the order of the conditions in the `frame_score` case statement, but if this order were to later be changed for some reason then this could cause an issue. I'd therefore refactor `spare?` like so:
```ruby
def spare?(frame)
  !strike?(frame) && frame.reduce(:+) == 10
end
```
therefore if it is a strike frame the reduce method won't get called on it.

* Extracting the validation from the `score` method and splitting this up into two different methods. At the moment both conditions call on the `game_in_progress?` method and the correct error message is only returned due to the order of the validation tests.

---

The [refactored version of my code](https://github.com/superchilled/launch-school-code-challenges/blob/f547c3e6a4b2cd49d1ca3f07936d65bd3185ae12/bowling/bowling.rb) as well as the [originally submitted version](https://github.com/superchilled/launch-school-code-challenges/blob/4d60e6039be4dad7391b7cf91ef68d5cead964e4/bowling/bowling.rb) are both available for comparison in my [Code Challenges GitHub repo](https://github.com/superchilled/launch-school-code-challenges).
