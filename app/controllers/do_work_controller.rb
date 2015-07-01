class DoWorkController < ApplicationController
  include ActionView::Helpers::NumberHelper
  def new
    #@locations = ["Boston","San Fransciso","Los Angeles", "Denver", "Boulder","Chicago","New York"]
    @locations = ["New York", "Boston", "Denver"]
    #@langs = ["ruby","python","C++","C","Node","Scala"]
    @langs= ["Node", "python"]
    @jobs = nil
    tmp_hsh = {}
    @hsh = {}
    @locations.each do |loc|
      total = 0
      @langs.each do |lang|
        @jobs = Github::Jobs.positions(search: "#{loc}, #{lang}")
        tmp_hsh.merge!("#{lang}" => @jobs.length)
        total += @jobs.length
      end
      tmp_hsh.each do |key, value|
        percent = (value.to_f / total.to_f) * 100
        @hsh.merge!("#{key}" => number_to_percentage(percent, precision: 0))
       #@hsh.merge!("#{key}" => number_to_percentage(value, precision: 0))
      end
    end
  end
  
end
