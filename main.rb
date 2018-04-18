# encoding: utf-8

require './game_controller'
Dir['./model/*.rb'].each { |file| require file }

def scene_a
  @hero = Hero.new('もよもと', 100, 10, 10, 5, 5)
  @monster = Actor.new('スライム', 88, 9, 9, 3, 2)
end

def scene_b
  @hero = Hero.new('もよもと', 280, 10, 14, 5, 5)
  @monster = Satan.new('りゅうおう', 300, 30, 12, 5, 6)
  @magic = Magic.new('メラゾーマ', 70, 15)
  @monster.magic_skill = @magic
end

def scene_c

end

def main
  scene_a
  game = GameController.new(@hero, @monster)
  game.run
end

main
