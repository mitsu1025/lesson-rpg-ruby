# encoding: utf-8

class Recover
   attr_reader :name, :atk, :hp
   def initialize(name, atk, hp)
      @name = name
      @atk = atk
      @hp = hp
   end
end
