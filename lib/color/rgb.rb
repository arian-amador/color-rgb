# -*- coding: utf-8 -*-
module Color
  class RGB
    attr_reader :r, :g, :b

    def self.from_array(rgb_array)
      if rgb_array.length != 3
        raise RGBArraySizeError.new("RGB array should contain 3 values")
      end
      self.new(rgb_array[0], rgb_array[1], rgb_array[2])
    end

    def self.from_int(rgb_int)
      red   = (rgb_int >> 16) & 0xFF;
      green = (rgb_int >> 8) & 0xFF;
      blue  = rgb_int & 0xFF;
      self.new(red, green, blue)
    end

    def self.from_float(f_array)
      red = (f_array[0] * 255).ceil
      green = (f_array[1] * 255).ceil
      blue = (f_array[2] * 255).ceil
      self.new(red, green, blue)
    end

    def initialize(r, g, b)
      @r = r.to_f
      @g = g.to_f
      @b = b.to_f

      validate_values
    end

    def to_lab
      xyz_color = Color::XYZ.from_rgb(self)
      Color::CIELab.from_xyz(xyz_color).to_a
    end

    def to_xyz
      Color::XYZ.from_rgb(self).to_a
    end

    def to_f
      [(@r / 255.0), (@g / 255.0), (@b / 255.0)]
    end

    def to_int
      rgb_int = r.to_i
      rgb_int = (rgb_int << 8) + g.to_i
      rgb_int = (rgb_int << 8) + b.to_i
    end

    def to_a
      [r.to_i, g.to_i, b.to_i]
    end

    private

    def validate_values
      if r > 255
        raise Color::RGBArrayValueOutOfBoundsError.new("R is #{r}")
      end

      if g > 255
        raise Color::RGBArrayValueOutOfBoundsError.new("G is #{g}")
      end

      if b > 255
        raise Color::RGBArrayValueOutOfBoundsError.new("B is #{b}")
      end
    end
  end
end
