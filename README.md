# East-Oriented Game of Life

This is an attempt to code the [Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) in a test-driven way contrained by the rules of [East-Oriented programming](http://www.confreaks.com/videos/4825-RubyConf2014-eastward-ho-a-clear-path-through-ruby-with-oo).

* Rule 1: Always Return Self
* Rule 2: Objects May Query Themselves
* Rule 3: Factories are Exempt

In other words: [Tell, Don't Ask](http://c2.com/cgi/wiki?TellDontAsk) -or- Command, Don't Query.

# Development Journal

*December 18, 2014*

I started coding using some of the guidelines from [Understanding the Four Simple Rules of Design](https://leanpub.com/4rulesofsimpledesign) by [Corey Haines](https://twitter.com/coreyhaines).

The first tests I wrote focused on `World#empty?`. Since the method cannot return a boolean, it takes a lambda as an argument. This lambda is only executed by `#empty?` if the world is indeed empty. I initially tried to test this using a mock object:

    it 'should be empty when first initialized' do
      empty_world = World.empty
      mock = double
      expect(mock).to receive(:message)
      empty_world.empty?(-> { mock.message })
    end

But this felt really awkward, so I switched to using a plain old variable:

    it 'should be empty when first initialized' do
      empty_world = World.empty
      world_is_empty = false
      @empty_world.empty?(-> { world_is_empty = true })
      expect(world_is_empty).to be true
    end

Spent a bit too much time thinking about how to hide the World's "dimensionality" from itself. As in, I don't think the world should need to know if it's 1D, 2D or 3D. That information should be hidden inside of Location. The World itself should just know that it has Locations, each of which may contain a live or dead cell. I've finally decided on a new WorldBuilder2D class, that will populate a World with it's locations.

*December 24, 2014*

Took some time to implement a position equality test on `Location#same_position?`. The goal being I was going to add a spec for `World#add_location` to expect identical locations to be added only once. The problem is, I don't know how to test for that without implementing `World#size`, which would break the no returns rule.

It should also be noted that not being able to return simple Booleans, as in the case of `World#empty?` and `Location#same_position?`, is grating. Building with a lambda argument that gets conditionally called feels awkward. In some descriptions of east-oriented coded boolean returns are allowed. Perhaps needing boolean methods is an east-oriented code smell? I'm going to start allowing boolean methods, otherwise I'll be forever mired in chains of conditional callbacks.

Extracted the x and y instance variables out of Location into a Coordinate2D class. This class will be responsible for knowing it's neighbours.

*December 26, 2014*

It's amazing how this style of programming makes me feel like I've forgotten how to code. I'm sure I could hack together a procedural Game of Life in less than an hour, but I'm not sure how many hours it would take to complete this version. This is partially because I'm learning two things at the same time here: TDD and East-Oriented OO. It should also be noted that I'm not doing TDD right. The tests are actually driving my code. Instead the tests have allowed me to discover the objects I need, but then I guess at the message they need to respond to, leading me to create unnecessary methods. Current status: Frustrated. ;)

*December 31, 2014*

A new beginning. I've deleted all the code and am starting again. I've tagged the [final state of the first attempt](https://github.com/stungeye/East-Oriented-Game-of-Life/tree/before_restart). To get a better feel for the East-Oriented style I'm going to base this attempt on [Jake Goulding's code found here](https://github.com/shepmaster/gdcr-no-return-values) and [blogged about here](http://jakegoulding.com/blog/2012/12/13/conways-game-of-life-without-return-values/). Once I get a feel for how this code works I will refactor it such that the rules don't leak into the Board class. I'd also like to replace the [x,y] representation of a point with a Location or Coordinate [Value Object](http://martinfowler.com/bliki/ValueObject.html). Value Objects are not East Oriented, but I think they would be an interesting addition here. For example, I might be able to create 1D, 2D and 3D Coordinate Value Objects that change the nature of the game without having to rewrite any other parts of the system.

I've taken a slightly different testing approach than Jake while re-implementing his version of the Game of Life. Jake only has tests for the Game class, with all of them depending on expectations of ui output. I'll be adding specs for other classes, starting with Board. To facilitate this I've modified Game such that it is initialized with an existing Board, rather than having the only instance of Board exist within a Game. This should give me the added benefit of being about to create Board factories later on.

Jake's specs focus on calling `Game#come_alive_at` and then expecting ui output for each cell brought to life. My spec for `Game#come_alive_at` only expects that message to be forwarded to the board. My spec for `Board#come_alive_at` depends on the existence of `Board#each_live_cell`, which takes a block and yields each live cell. So if I call `#come_alive_at` N times, `#each_live_cell` should yield control N times. Yielding cells like this feels a little West-y, but it's still not a query. The block passed to `Board#each_live_cell` is called with each cell as an argument.

*January 1, 2014*

Started by implementing the `Board#points_surrounding` and `Board#fringe` both of which are private so they can return data. I've simplified their implementation by removing the use of `Enummerable#flat_map`. I did a reverse spike here, TDDing these methods and then removing those tests after setting the methods private. The `Board#fringe` is fascinating. In my previous Game of Life implementations I never realized that you only need to check on dead cells that are touching a live cell. Makes sense with respect to the rules, but in past implementations with the board being a 2D array I would just loop through all positions.

Next I TDD'd the ConwayAliveRules and ConwayDeadRules classes. In Jake's implementation the rules were in rules classes but they also existed in `Board#find_live_cell_neighors` and `Board#find_dead_cell_neighbors`. Now that the rules are tested separately, testing the `Board#apply_rules` (called `Board#time_passes` in Jake's implementation) need only verify that the rules are applied, but need not recheck their actual expected effects.

After implementing rule application it looks like the Game class isn't needed. It currently only delegates (either explicitly or via Forwardable) to the board. I'll refactor it away. I'm also going to refactor the Rules classes such that `#apply` becomes a class method to which the board, cell and number of neighbour is passed. No need to instantiate these rules. I'll have to use a class double for testing them now. Once that refactor is complete these rules could be passed into the board on initialization. And then `Board#apply_rules` would only need to take a new Board as an argument. Finally, I'll write an integrate spec to ensure that the conway rule set works with the Board as expected.

*January 2, 2014*

So I refactored away the Game class. The source code line count dropped by 20 lines, with the Board class growing by only four lines. A few things I've noticed:

* Board now has too many responsibilities. I think almost all of Board's private methods could be extracted into two separate classes: A Board factory to handle rule application and a Location value object. Those extraction would leave Board with the single responsibility of managing the Set of cells.
* Board should likely be renamed World since Board implies a 2D topology and I want to extract out the topology anyway.

I'm also having a hard time deciding how best to refactor the rules. Currently when generating a new board you have to do the following:

    new_board = Board.empty
    existing_board.apply_rules(ConwayAliveRules.new(new_board), ConwayDeadRules.new(new_board))

That seems like a lot of ceremony just to generate the next generation board, but I'm not exactly sure how to improve it. One rules class that contains the alive and dead rules? Some sort of rule application Board factory? We'll see.

*January 3, 2014*

Renamed the Board class to world. I've [tagged this commit](https://github.com/stungeye/East-Oriented-Game-of-Life/tree/reimplementation_complete) as a complete re-implementation of Jason's code. I've created [a branch](https://github.com/stungeye/East-Oriented-Game-of-Life/tree/value_object) to attempt the creation of a value object for coordinates.

The `Coordinate2D` value object was created using the [Values gem](https://github.com/tcrayford/Values). Value objects by their very nature are not eastward, but they do provide a nice place to extract the 2D topology out of the World class. The only method I implemented on `Coordinate2D` was `neighbouring_coordinates` which returns a collection of the object's eight neighbours. I considered this a Factory method, so it is permitted to return data.

I've tried thinking of a way to extract rules appliation out of World, but I couldn't think of a elegant way. In that case, all that is left to do is an integration spec for the Conway rules, breaking the various classes out to their own files, and a few 1D and 2D demos.

*Janary 4, 2014*

Separated out classes and specs into their own files. I also created an integration spec for Conway's rules that involved both a static world and a two-phase oscillating world. These test led me to create a new RulesetWorldBuilder class, which is a ruleset based World factory. Take a look at [the Conway demo](https://github.com/stungeye/East-Oriented-Game-of-Life/blob/master/examples/conway_demo.rb) to see how it works.

The only things left to do is to create a few more example using different rules sets and/or different topologies. I think I'll create a 1D coordinate value object so that I can create some 1D demos using Wolfram's rules. Oh and when researching Wolfram's rules I realized that my World will only support half of his 1D rulesets, [the even numbered ones](https://en.wikipedia.org/wiki/Elementary_cellular_automaton#Single_1_histories). This is because the odd numbered Wolfram rules involve bringing cells to life if they have no neighbours. My World assumes that the only dead cells that matter are "fringe" cells, one's that are touching at least one live cell. Without this assumption my World would need to be configured to a specific width and height, but with the Game of Life the world is supposed to be of an infinite size. Oh well, such is life. ;)

Implementing a 1D topology with a Wolfram Rule 90 demo was a snap. One further complication for Wolfram rules is that not just the number of neighbours count but their positions too. So a single left neighbour can lead to a different outcome compared to a single right neighbour. (See [Rule 30](https://en.wikipedia.org/wiki/Rule_30)) One possible fix would have the `#apply` method of rules to take the collection of alive neighbours as an argument, rather than the alive neighbour count. I'll leave that for another day.

A short while later... I fixed the rules class to allow for all even 1D Wolfram rules. I also added a GenericRule class for all rules to inherit from. This way a rule can be implemented as follows:

    class Rule90 < GenericRule
      protected

      def come_to_life?(coordinate, alive_neighbours)
        number_of_neighbours == 1
      end
    end

I think that's a wrap folks!

# (UN)LICENSE

This is free and unencumbered software released into the public domain. See UNLICENSE for details.
