require 'nokogiri'
require 'nokogiri-styles'

class SketchesController < ApplicationController

  def create

    @svg_path = "#{Rails.root}" + "/public/images/room_#{params[:room_choice]}.svg"

    @svg_file = File.open(@svg_path) { |f| Nokogiri::XML(f) }

    @colors = {sofa: params[:sofa],
               cushion_one: params[:cushion_one],
               cushion_two: params[:cushion_two],
               room_wall: params[:room_wall],
               room_floor: params[:room_floor],
               lamp: params[:lamp],
               carpet: params[:carpet],
               coffee_table: params[:coffee_table]}

    @colors.each do |key, value|
      target = @svg_file.at_css("#" + key.to_s)
      target['style'] = "color:#000000;fill:#{value};fill-opacity:1;stroke:none;stroke-width:0.5;marker:none;visibility:visible;display:inline;overflow:visible;enable-background:accumulate"

    end


    ##################################################################

    @canva = Canva.find(params[:canva_id])
    @sketch = Sketch.new
    @sketch.save
    @canva.sketch = @sketch
    @user = @canva.user_id
    redirect_to "/users/#{@user}"
  end

  private

  def sketch_params
    if params[:sketch].present?
      params.require(:sketch).permit(:sofa,:cushion_one,:cushion_two,:room_wall,:room_floor,:lamp,:carpet,:coffee_table)
    end
  end

end
