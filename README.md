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

Took some time to implement a position equality test on Location, #same_position?. The goal being I was going to add a spec for World#add_location to expect identical locations to be added only once. The problem is, I don't know how to test for that without implementing World#size, which would break the no returns rule. 

It should also be noted that not being able to return simple Booleans, as in the case of World#empty? and Location#same_position?, is grating. Building with a lambda argument that gets conditionally called feels awkward. In some descriptions of east-oriented coded boolean returns are allowed. Perhaps needing boolean methods is an east-oriented code smell? I'm going to start allowing boolean methods, otherwise I'll be forever mired in chains of conditional callbacks.

Extracted the x and y instance variables out of Location into a Coordinate2D class. This class will be responsible for knowing it's neighbours.

*December 26, 2014*

It's amazing how this style of programming makes me feel like I've forgotten how to code. I'm sure I could hack together a procedural Game of Life in less than an hour, but I'm not sure how many hours it would take to complete this version. This is partially because I'm learning two things at the same time here: TDD and East-Oriented OO. It should also be noted that I'm not doing TDD right. The tests are actually driving my code. Instead the tests have allowed me to discover the objects I need, but then I guess at the message they need to respond to, leading me to create unnecessary methods. Current status: Frustrated. ;)

*December 31, 2014*

A new beginning. I've deleted all the code and am starting again. I've tagged the [final state of the first attempt](https://github.com/stungeye/East-Oriented-Game-of-Life/tree/before_restart). To get a better feel for the East-Oriented style I'm going to base this attempt on [Jake Goulding's code found here](https://github.com/shepmaster/gdcr-no-return-values) and [blogged about here](http://jakegoulding.com/blog/2012/12/13/conways-game-of-life-without-return-values/). Once I get a feel for how this code works I will refactor it such that the rules don't leak into the Board class. I'd also like to replace the [x,y] representation of a point with a Location or Coordinate [Value Object](http://martinfowler.com/bliki/ValueObject.html). Value Objects are not East Oriented, but I think they would be an interesting addition here. For example, I might be able to create 1D, 2D and 3D Coordinate Value Objects that change the nature of the game without having to rewrite any other parts of the system.

# (UN)LICENSE

This is free and unencumbered software released into the public domain. See UNLICENSE for details.
