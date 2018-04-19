# encoding: utf-8

require './game_controller'
Dir['./model/*.rb'].each { |file| require file }

# 殴り合い
def scene_a
  @hero = Hero.new('もよもと', 100, 10, 10, 5, 5)
  @monster = Actor.new('スライム', 88, 9, 9, 3, 2)
end

# 魔王 は 魔法 を 使える
def scene_b
  @hero = Hero.new('もよもと', 280, 10, 14, 5, 5)
  @monster = Satan.new('りゅうおう', 300, 30, 12, 5, 6)
  @magic = Magic.new('メラゾーマ', 70, 15)
  @monster.magic_skill = @magic
end

# ゆうしゃ は 装備品 を 調達した
# 魔王 は 魔法 を 使える
def scene_c

end

# 魔王 と 勇者 は 回復魔法を覚えた
# ゆうしゃ は 装備品 を 調達した
# 魔王 は 魔法 を 使える
def scene_d

end

def main
  scene_b
  game = GameController.new(@hero, @monster)
  game.run
end

main
