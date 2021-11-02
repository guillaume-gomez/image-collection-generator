class GenerativeArt
  SOURCE_PATH = "./layers"
  attr_reader :layers_data


  def initialize(layers_position, source_path = SOURCE_PATH)
    @layers_data = []
    @source_path = source_path

    parse_layers_folder(layers_position)
  end


  def generate_combination_paths
    combinations = combine
    combinations.map{ |combination| generate_path_from_combination(combination) }
  end

  private
  def combine
    images_paths = @layers_data.map{|layer_data| layer_data[:images_path] }
    first, *rest = images_paths
    first.product(*rest)
  end

  def generate_path_from_combination(combination)
    combination.map.with_index do |item, index|
      "#{@source_path}/#{@layers_data[index][:name]}/#{item}"
    end
  end

  def parse_layers_folder(layers_name_and_position)
    layers_name_and_position.each do |layer|
      layer = { name: layer, images_path: parse_layer_images(layer) }
      @layers_data << layer
    end
  end

  def parse_layer_images(layer_type)
    images_by_layer = Dir.entries("#{SOURCE_PATH}/#{layer_type}").reject{|entry| entry == "." || entry == ".."}
  end
end