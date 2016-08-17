## Code Review

In terms of actual coding/ implementation I think this challenge was perhaps a litte more straightforward than some recent challenges. The challenging aspect, as Kevin suggested, was the problem decomposition - or 'translating' the problem description into precise requirements that can be coded against.

One of those requirements was to create an initial representation of a 'flat' diamond that could then be iterated through to create the rows. Within the submitted solutions there seemed to be two main approaches to this either to start off with a complete row, e.g.
```ruby
['A', 'B', 'C', 'D', 'E', 'D', 'C', 'B', 'A']
```

or to start off with half a row (i.e. ranging from 'A' to the middle letter), e.g.
```ruby
['A', 'B', 'C', 'D', 'E']
```

Some solutions used strings for the strucutre and some arrays, but the underlying structure is the same in either case. There were some solutions that didn't start with an actual representation of a flat diamond but chose instead to iterate through a range or loop thorugh a counter in order to build the rows, such as Abdulhafiz, Daniel, Carlo and David Renz, but I feel like the mental model is the same - the range or counters that are looped through are still effectively representations of the 'flat' diamond structure, just abstracted out.

A lot of the solutions that started off with the 'half' diamond structure then created a reversed copy (minus the bottom row) and joined the two 'halves' together. Pete's (second) solution is quite interesting in this respect in that he iterates through a 'half' diamond structure in his `build` method but that iteration maps to a 'full' diamond (which is a 'square' of space-filled strings) in `add_to_display`.

As a mental model I tend to prefer the 'full row' as a starting point and then iterating through this as opposed to those solutions that stitched two 'halves' together.

Another requirement of the problem was building the actual 'rows' of the diamond from the starting point of the 'flat' diamond. Specific operations within this requirement was adding the correct amount of 'inner' and 'outer' (left and right) padding. There seemed to be three basic approaches to this:

Combine all the 'parts' of a row - 
```ruby
left_padding + letter + inner_padding + letter + right_padding
```

Create the inner section first and then centre it -
```ruby
row = letter + inner_padding + letter
row.center(size)
```
These two aproaches basically share the same mental model and the use of `String#center` is just a bit of shortcut so that there is one less thing to calculate (the outer padding).

The other, quite different, model was to build a 'complete' row and then substitute parts of it. Abdulhafiz, Alexandra and Pete (second solution) all use a string of the correct size 'filled' with spaces and then substiute in the appropriate letter based on indices. Brian's model is similar but he approaches it from a different angle in that he starts with a 'complete' row filled with letters and then substitutes in spaces using `gsub` - I thought this was an interesting approach.

I think both these models are valid but I generally found the 'combination' solutions more readable than the 'substitution' ones.

1st - Pete (original solution). I actually prefered Pete's original solution over his final one; I didn't find it difficult to follow (although that might be because my own solution was very similar). I think one area where the readability could maybe be improved is line `17` - the combination of the ternary and string concatenation here makes the line fairly dense and this could maybe be abstracted out a bit.

2nd - David Kurutz. I like the models used for the various parts of the solution and found it to be very readable.

3rd - Brian. Although I generally preferred the 'combination' solutions over the 'substitution' ones I found Brian's solution of building `unsubstituted_line`s and then using `gsub` to replace the non-matching letters with spaces to be really interesting and pretty easy to parse.
