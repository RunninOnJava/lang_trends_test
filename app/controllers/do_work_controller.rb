class DoWorkController < ApplicationController
  include ActionView::Helpers::NumberHelper
  def home
    @locations = ["Boston","San Francisco","Los Angeles", "Denver", "Boulder","Chicago","New York"]
    @langs= ["Node", "python","C++","C","Scala","ruby"]
    @jobs = nil
    tmp_hsh = {}
    @hsh = Hash.new
    @final = Hash.new
    @locations.each do |loc|
      total = 0
      @hsh ={}
      @langs.each do |lang|
        @jobs = Github::Jobs.positions(search: "#{loc}, #{lang}")
        tmp_hsh.merge!("#{lang}" => @jobs.length)
        total += @jobs.length
      end
      tmp_hsh.each do |key, value|
        #Deal with NaN exception (occurs when city not found) by making percent to always be a number
        if total == 0 then percent = 0 
          else percent = (value.to_f / total.to_f) * 100
        end
        #replace hsh of lang=>total with lang->percentage of total jobs
        @hsh.merge!("#{key}" => number_to_percentage(percent, precision: 0))
        #store the location => {lang => percentage}
        @final.store("#{loc}", @hsh)
      end
    end
  end
end
