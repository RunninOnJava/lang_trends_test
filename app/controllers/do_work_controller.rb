class DoWorkController < ApplicationController
  include ActionView::Helpers::NumberHelper
  def new
    @locations = ["Boston","San Francisco","Los Angeles", "Denver", "Boulder","Chicago","New York"]
    #@locations = ["New York", "Boston", "Denver", "Los Angeles","Chicago","Boulder"]
    #@langs = ["ruby","python","C++","C","Node","Scala"]
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
        if total == 0 then percent = 0 
          else percent = (value.to_f / total.to_f) * 100
        end
        @hsh.merge!("#{key}" => number_to_percentage(percent, precision: 0))
       @final.merge!("#{loc}" => @hsh)
       
      end
    end
  end
  
end
