# A Pythagorean triplet is a set of three natural numbers, {a, b, c}, for
# which, #a**2 + b**2 = c**2
# For example, 3**2 + 4**2 = 9 + 16 = 25 = 5**2.
####
class Triplet
  attr_reader :number_set

  @@min = 0
  @@max = 0
  @@sum = nil
  @@triplet
  @@triplet_set = []

  def initialize(a, b, c)
    @number_set = [a, b, c]
  end 

  def sum 
    number_set.inject(0, &:+)
  end  

  def product
    number_set.inject(&:*)
  end  

  def pythagorean?
    number_set[0] ** 2 + number_set[1] ** 2 == number_set[2] ** 2
  end 

  def largest_factor
    number_set.max
  end

  def smallest_factor
    number_set.min
  end  
    
  def self.where(min_factor: 3, max_factor: 100, sum: nil)
    @@triplet_set = []
    @@min = min_factor
    @@max = max_factor
    @@sum = sum
    create_primitive_triplets
    create_scaled_up_triplets
    if !sum.nil?
      remove_wrong_sums
    end  
    
    return @@triplet_set
  end 

  def self.create_primitive_triplets
    m = 1
    n = 2
    create_first_triplet(m, n)
      
    while (@@triplet.smallest_factor >= @@min) &&
          (@@triplet.largest_factor <= @@max)
      if (@@sum.nil? || (@@triplet.sum <= @@sum))
        @@triplet_set << @@triplet
      end  
      m += 1
      n += 1
      create_triplet(m, n)
    end  

    return @@triplet_set  
  end 

  def self.create_scaled_up_triplets 
    @@triplet_set.each do |t|
      i = 2
      a = t.number_set[0] * i
      b = t.number_set[1] * i
      c = t.number_set[2] * i
      @@triplet = self.new(a, b, c)  
        
      while (@@triplet.smallest_factor >= @@min) &&
            (@@triplet.largest_factor <= @@max) 
        if (@@sum.nil? || (@@triplet.sum == @@sum))
          @@triplet_set << @@triplet
        end  
       
        i += 1 
        a = t.number_set[0] * i
        b = t.number_set[1] * i
        c = t.number_set[2] * i
        @@triplet = self.new(a, b, c)
      end
    end

    return @@triplet_set 
  end 

  def self.create_first_triplet(m, n)
    a = n ** 2 - m ** 2
    b = 2 * n * m
    c = n ** 2 + m ** 2
    
    while a < @@min do
      a*=2
      b*=2
      c*=2
    end 

    return @@triplet = self.new(a, b, c) 
  end

  def self.create_triplet(m, n)
    a = n ** 2 - m ** 2
    b = 2 * n * m
    c = n ** 2 + m ** 2
    @@triplet = self.new(a, b, c)
  end  
    
  def self.remove_wrong_sums
    @@triplet_set.delete_if { |t| t.sum != @@sum }
    return @@triplet_set
  end          
end