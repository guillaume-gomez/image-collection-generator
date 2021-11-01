require 'rmagick'
include Magick


def merge_images(filename_sources)
  return nil if filename_sources.empty?
  result = Image.read(filename_sources[0]).first
  filename_sources[1..].each do |filename|
    temp = Image.read(filename).first
    result = result.composite(temp, SouthGravity, OverCompositeOp)
  end
  result
end


result = merge_images(["image1.png", "image2.png", "image3.png"])
result.write("mabite.png")