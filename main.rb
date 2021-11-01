require 'rmagick'
include Magick

result = ImageList.new("image1.png")
[2,3].each do |number|
  temp = ImageList.new("image#{number}.png")
  result = result.composite(temp, SouthGravity, OverCompositeOp)
end
