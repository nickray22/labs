require 'pry'

module Killable
  def alive?
    self.health > 0
  end

  def dead?
    not self.alive?
  end
end

class Mage
  attr_accessor :health, :level, :name, :weapon 
  include Killable

  def initialize(name, level=1, weapon)
    @hitpoints = 20
    @level = level
    @health = level * @hitpoints
    @name = name
    @weapon = weapon
    if @weapon.include?('shock')
      @weapon_damage = 15 * level
      @damage_descriptor = 'electrocutes'
    elsif @weapon.include?('fire')
      @weapon_damage = 20 * level
      @weapon_descriptor = 'torches'
    elsif @weapon.include?('ice')
      @weapon_damage = 10 * level
      @weapon_descriptor = 'freezes'
    end
  end

  def damage
    rand(1..@weapon_damage)
  end

  def attack(target) 
    damage = self.damage
    target.health -= damage
    puts "#{self.player_name} #{@weapon_descriptor} #{target.player_name} for #{damage} hit points."
  end

  def player_name
    @name
  end
end

class Demon
  include Killable

  attr_accessor :health, :level, :name

  def initialize(name, level=1)
    @name = name
    @level = level
    @hitpoints = 50
    @health = @hitpoints * level
  end

  def max_damage
    20 * @level
  end

  def damage
    rand(1..max_damage)
  end

  def attack(target)
    damage = self.damage
    target.health -= damage
    puts "#{self.player_name} hellishly guts #{target.player_name} for #{damage} hit points."
  end

  def player_name
    @name
  end
end

class Conflict
  attr_reader :hero, :villain
  
  def initialize(hero, villain)
    @hero = hero
    @villain = villain
  end

  def fight
    puts "The hero #{@hero.player_name} will now face off in the arena against the villain #{@villain.player_name}!"
    puts "#{@hero.player_name} Health: #{@hero.health}"
    puts "#{@villain.player_name} Health: #{@villain.health}"
    until (@hero.dead?) || (@villain.dead?)
      turn = rand(1..2)
      if turn == 1
        @hero.attack(@villain)
      else
        @villain.attack(@hero)
      end
    end
    if @hero.dead?
      puts "#{@villain.player_name} has slain our valiant hero #{@hero.player_name}. The universe is doomed!"
    else
      puts "#{@hero.player_name} soundly defeated the villain #{@villain.player_name}. We are all saved!"
    end
  end
end

hero = Mage.new "Nick", 5, 'ice staff'
villain = Demon.new 'Grand Demon', 3

binding.pry

tourney = Conflict.new(hero, villain)
tourney.fight


