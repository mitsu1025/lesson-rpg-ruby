# encoding: utf-8
require_relative './actor'
require_relative './magic'

class Satan < Actor
  attr_accessor :magic_skill

  def attack
    if !@magic_skill.nil?
      random = Random.new(hp).rand(5)
      if random == 4
        self.mp -= @magic_skill.mp
        if self.mp >= 0
          { atk: @magic_skill.atk, msg: "#{name}は、#{@magic_skill.name}を放った！" }
        else
          super
        end
      else
        super
      end
    else
      super
    end
  end
end
