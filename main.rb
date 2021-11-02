require 'byebug'
require 'rmagick'
require_relative 'generative_art'
include Magick

SOURCE_PATH = "layers"
DIST_PATH = "./dist"

# unused
def merge_images(filename_sources)
  return nil if filename_sources.empty?
  result = Image.read(filename_sources[0]).first
  filename_sources[1..].each do |filename|
    temp = Image.read(filename).first
    result = result.composite(temp, SouthGravity, OverCompositeOp)
  end
  result
end

gen_art = GenerativeArt.new(['background', 'ball', 'eye_color', 'iris', 'shine', 'bottom_lid', 'top_lid'], SOURCE_PATH)
combinations_paths = gen_art.generate_combination_paths
print "#{combinations_paths.count} found for this assets part"

combinations_paths.first(10).each_with_index do |combination, index|
  imagelist = ImageList.new(*combination)
  #imagelist.each { |i| i.background_color = "transparent" }
  image = imagelist.flatten_images
  image.write("#{DIST_PATH}/#{index}.png")

  imagelist.each { |i| i.destroy! }
  image.destroy!
end
nil
