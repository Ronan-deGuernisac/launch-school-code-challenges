## Code Review

That was an interesting weekly challenge with a couple of contrasting problems to solve. In the opening post of this thread Kevin suggested that the key to both these problems might be on the data-structure(s) chosen initially; I think that was definitely proved true of the [Scrabble Score](https://launchschool.com/exercises/affefe14) problem, but less so of [Kindergarten Garden](https://launchschool.com/exercises/d0867e33)

### Kindergarten Garden

With this problem I think there is less flexibility when it comes to choosing the initial data structures. There are two sets fo data for which a structure needs to be selected: the mapping of seeds to plants (i.e. the letters `CGRV` which are passed as a string as an argument to `Garden#new` and their equivalent symbols `:clover, :grass, :radishes, :violets` which need to be returned in an Array when the student-name methods are called) and the structure for the default set of students.

For this first structure a flat hash, with the letter strings as keys and the symbols as values, makes the most sense, and I think is the structure that pretty much every submitted solution used:
```ruby
SEED_PLANT_MAP = {
  'C' => :clover,
  'G' => :grass,
  'R' => :radishes,
  'V' => :violets
}.freeze
```

With regards to the default set of students, during the live session Kevin suggested that it would be a good idea to use a structure analogous to the rows of plant pots as this would simplify the subsequent processing logic, something like:
```ruby
{"alice" => [0, 1], "bob" => [2, 3]}
```
While I can see that this approachwould work well for the tests where the default set of students is used, for the later tests - `DisorderedTest` and `TwoGardensDifferentStudents` - the default students are not used and different students are passed in as an argument to `Garden#new` in the form of an `Array` of `String` objects.

Given that the different students are in the form of an Array, it makes sense to me for the default students to be in this format also, otherwise you're having to introduce additional logic into the program to deal with these two cases (default data and new data input). 

I guess you could have some sort of processing logic to parse the input Array to the Hash structure that Kevin suggested but in that case why not just start with an Array in the first place - you still ultimately need require that same processing logic somewhere in your program. To me this is a situation where sameness makes sense, and I think this is kind of what Sandi Metz means when she says [make everything the same](http://www.sandimetz.com/blog/2016/6/9/make-everything-the-same).

Additionally, I feel like there is already an implicit mapping of the positions within the Array structure anyway, given that the students are ordered alphabetically there's a relationship between the student position in the Array (index) and the pots that are assigned - the key here is the need to understand that the pots are doubled-up so any 'assignment operation' needs to be performed twice for each Array index. I don't feel like this is too complex a mental model to deal with.

Again, I think pretty much all of the submitted solutions followed this path and used an Array structure for the default students.

Given these pretty fixed starting points (Array for students and flat hash for the plant mapping), the main design decisions boil down to the logic of how to 'assign' the pots to each student and also how to deal with the student method calls.

I found Tyler's solution to be the most readable; there isn't too much abstraction going on but the individual methods aren't overly complicated either - it's nicely balanced. I like the way `@rows` is iterated through - using that mental model I mentioned earlier of performing each 'assignment operation' twice per student index. Kevin suggested that `method_missing` might not be a good option as there would be the risk of someone just using any random method call on a `Garden` object; personally I think using this method is ok as long as a conditional is used to guard against that  sort of behaviour - as in this case where the method uses `super` if `method_id` doesn't exist in the `@students` array (this is actually what the [documentation for `method_missing`](http://ruby-doc.org/core-2.3.1/BasicObject.html#method-i-method_missing) recommends).

I also liked David Renz' solution - the `define_student_methods` is straightforward and easy to parse. I like the `plant_assigment` method - nice idea to create hash here by zipping two arrays (Carlo Gonzales' solution took this approach too). Overall the solution is pretty readable though I think the `garden_setup` method could maybe do with some refactoring - there's a lot going on here as most of the heavy lifting is done within this one method and I think some of it could probably be simplified a little (one thing I'd definitely do for example is move line `33` up to the `initialize` method).

I quite liked Pete's solution - again it's pretty well balanced in terms of abstraction versus method complexity - but overall found it slightly less readable than Tyler's or David Renz'

* 1st - Tyler Lippert
* 2nd - David Renz
* 3rd - Pete Hanson

---

Sorry to choose the same three people for both challenges but I genuinely thought that these were the best solutions! 
