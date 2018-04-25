# encoding: utf-8
# MODE    A:自動  M:手動操作
require_relative './actor'
require_relative './item'

class Hero < Actor
  attr_reader :physical_atk, :physical_defe
  attr_accessor :weapon, :armor, :recovery_magic, :mode

  def initialize(name, hp, mp, atk, defe, spd, team = nil)
    super
    @physical_atk = atk
    @physical_defe = defe
  end

  def attack
    if can_use_recovery_magic?
      random = Random.new.rand(5)
      if random == 4
        self.mp -= @recovery_magic.mp
        self.hp = [@recovery_magic.hp + self.hp, self.max_hp].min
        return { atk: nil, msg: "♡♡#{name}は、#{@recovery_magic.name}を唱え、体力を回復した。(HP:#{self.hp} MP:#{self.mp})♡♡"}
      end
    end

    return super if @weapon.nil?
    { atk: @atk, msg: "#{name}は、#{@weapon.name}で殴りかかった！" }
  end

  def equip
    equip_weapon
    equip_armor
  end

  def can_use_recovery_magic?
    return false if @recovery_magic.nil?
    return false if (@mp - @recovery_magic.mp) < 0
    true
  end

  def use_recovery_magic
    self.mp -= @recovery_magic.mp
    self.hp = [@recovery_magic.hp + self.hp, self.max_hp].min
    { atk: nil, msg: "♡♡#{name}は、#{@recovery_magic.name}を唱え、体力を回復した。(HP:#{self.hp} MP:#{self.mp})♡♡"}
  end

  private

  def equip_weapon
    return @atk = @physical_atk if @weapon.nil?
    @atk = @physical_atk + @weapon.atk
    p "#{name}は#{@weapon.name}を装備した。(攻撃力:#{@physical_atk}->#{atk})"
  end

  def equip_armor
    return @defe = @physical_defe if @armor.nil?
    @defe = @physical_defe + @armor.defe
    p "#{name}は#{@armor.name}を装備した。(守備力:#{@physical_defe}->#{defe})"
  end
end
