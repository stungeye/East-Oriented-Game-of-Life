# East-Oriented Game of Life

This is an attempt to code the [Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) in a test-driven way contrained by the rules of [East-Oriented programming](http://www.confreaks.com/videos/4825-RubyConf2014-eastward-ho-a-clear-path-through-ruby-with-oo).

* Rule 1: Always Return Self
* Rule 2: Objects May Query Themselves
* Rule 3: Factories are Exempt

In other words: [Tell, Don't Ask](http://c2.com/cgi/wiki?TellDontAsk) -or- Command, Don't Query.

# Development Journal

I started coding using some of the guidelines from [Understanding the Four Simple Rules of Design](https://leanpub.com/4rulesofsimpledesignhttps://leanpub.com/4rulesofsimpledesign) by [Corey Haines](https://twitter.com/coreyhaines).

The first tests I wrote focused on the World class's `#empty?` method. Since the method cannot return a boolean, it takes a lambda as an argument. This lambda is only executed by `#empty?` if the world is indeed empty. I initially tried to test this using a mock object:

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

# (UN)LICENSE

This is free and unencumbered software released into the public domain. See UNLICENSE for details.