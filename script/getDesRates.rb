# Get Rates of Desjardins
#!/usr/bin/env ruby
require "rss/1.0"
require "rss/2.0"
require "open-uri"
require "rubygems"
gem "activerecord"
require "active_record"

ActiveRecord::Base.establish_connection(
  :adapter => "mysql2",
  :host => "localhost",
  :username => "root",
  :password => "",
  :socket => "/tmp/mysql.sock",
  :encoding => "utf8",
  :database => "ryokin_development")

class Rate < ActiveRecord::Base
end

class Category < ActiveRecord::Base
end

class CategoryRateType < ActiveRecord::Base
end

class RateType < ActiveRecord::Base
end

source ="http://rss.desjardins.com/TauxFixeFerme"
content = ""
type_name = "TauxFixeFerme";

open(source) do |s| content = s.read end
rss = RSS::Parser.parse(content, false)

description = rss.channel.item.description



description.each do |x|
  year = 0
  rates_ar = Rate.new
  
  rate_type = RateType.new
  
  cat_rate_type = CategoryRateType.new

  # Get existing rate
  #rate_exist = Rate.all(:joins => :category, :conditions => {:bank_id => 1, :section => 'taux fixe'})

  #puts 'RATES: ', rate_exist
  
  # Verif if hypotheque exist
  cat_hypotheque = Category.find(:first, :conditions => {:name => 'hypotheque'})
  if !cat_hypotheque
    cat = Category.new 
    cat.name = "hypotheque"
    cat.save
    cat_id = cat.id
  else
    cat_id = cat_hypotheque.id
  end

  # Regex
  x =~ /(\d{1,3}) (mois|an|ans).*(\d{1,}\.\d{3,})/i

  if $1 != nil && $2 != nil && $3 != nil
    if $2 == 'mois'
      year = $1
    elsif $2 == 'an' || $2 == 'ans'
      year = $1.to_i * 12
    end
    puts "->#{year} - #{$3.to_f}"

    # Save Rate Type
    rate_type.name = type_name
    rate_type.nb_month = year
    rate_type.save
    rate_type_id = rate_type.id
    
    # Save Category Rate Type
    cat_rate_type.category_id = cat_id
    cat_rate_type.rate_type_id = rate_type_id
    cat_rate_type.save
    cat_rate_type_id = cat_rate_type.id
    
    # Save Rates
    rates_ar.bank_id = 1 # Desjardins
    #rates_ar.category_id = cat_id
    rates_ar.category_rate_type_id = cat_rate_type_id
    rates_ar.ratetype_id = rate_type_id
    rates_ar.rate = $3.to_f    
    rates_ar.save
    
  end

end

#puts description