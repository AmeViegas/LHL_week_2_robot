class Robot

  attr_reader :position, :items, :items_weight
  attr_accessor :health, :equipped_weapon
  DEFAULT_DAMGE = 5

  def initialize
    @position = [0,0]
    @items = []
    # @items_weight = 0
    @health = 100
    @equipped_weapon = nil
  end

  def move_left
    # this is using the instance variable and
    # updating. per VC - should use reader instead
    # so that changes become easier. @position[0]
    position[0] -=1
  end

  def move_right
    position[0] += 1
  end

  def move_up
    position[1] += 1
  end

  def move_down
    position[1] -= 1
  end

  def pick_up(item)
    return unless Item
    if items_weight + item.weight <= 250
      @items << item
      if item.is_a?Weapon
        @equipped_weapon = item
      end
      true
    end
  end

  # per VC do it as a method rather than a instance
  # because this will control if item weight
  # changes elsewhere.
  def items_weight
    weight = 0
    items.each do |item|
      weight += item.weight
    end
    weight
  end

  def capacity(item)
    item.weight + @items_weight <= 250
  end

  def wound(damage_amt)
    @health -= damage_amt
    @health = 0    if (@health - damage_amt) < 0

  end

  def heal(healing_amt)
    @health += healing_amt
    @health = 100 if (@health + healing_amt) > 100

  end

  def attack(robot2)
    if self.equipped_weapon.nil?
      robot2.wound(DEFAULT_DAMGE)
    else
      @equipped_weapon.hit(robot2)
    end
  end
end
