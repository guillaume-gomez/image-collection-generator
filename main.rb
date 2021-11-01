require 'rmagick'
require_relative 'generative_art'
include Magick

SOURCE_PATH = "layers"
DIST_PATH = "./dist"

def merge_images(filename_sources)
  return nil if filename_sources.empty?
  result = Image.read(filename_sources[0]).first
  filename_sources[1..].each do |filename|
    temp = Image.read(filename).first
    result = result.composite(temp, SouthGravity, OverCompositeOp)
  end
  result
end


gen_art = GenerativeArt.new(SOURCE_PATH)
combinations_paths = gen_art.generate_combination_paths

print "#{combinations_paths.count} found for this assets part"

combinations_paths.shuffle.first(25).each_with_index do |combination, index|
 image = merge_images(combination)
 image.write("#{DIST_PATH}/#{index}.png")
end
