require "rss/1.0"
require "rss/2.0"
require 'net/http'
require "open-uri"

namespace :scrapper do 
  namespace :desjardins do
    
    task :delete => :environment do
      if RAILS_ENV == 'development' 
        
      else
        puts "Task can only run in dev mode"
      end      
    end
    
    # Task order list
    task :load_all => [:desj_hypo_closed_fixed]
    
    desc 'load data from the RSS'
    task :desj_hypo_closed_fixed => :environment do

      # Get Rates of Desjardins
      source ="http://rss.desjardins.com/TauxFixeFerme"
      content = ""
      type_name = "TauxFixeFerme";

      open(source){|s| content = s.read}
      rss = RSS::Parser.parse(content, false)

      descriptions = rss.channel.item.description

      descriptions.each do |description|
        year = 0
        
        # Get existing rate
        #rate_exist = Rate.all(:joins => :category, :conditions => {:bank_id => 1, :section => 'taux fixe'})

        #puts 'RATES: ', rate_exist

        # Verif if hypotheque exist
        cat = Category.find_or_create_by_name 'hypotheque'

        # Regex
        description =~ /(\d{1,3}) (mois|an|ans).*(\d{1,}\.\d{3,})/i

        if $1 != nil && $2 != nil && $3 != nil
          if $2 == 'mois'
            year = $1
          elsif $2 == 'an' || $2 == 'ans'
            year = $1.to_i * 12
          end
          puts "->#{year} - #{$3.to_f}"


          rate_type = RateType.create(:name => type_name, :nb_month => year)
          category_rate_type = CategoryRateType.create(:category => cat, :rate_type => rate_type)
          rate = Rate.create(:bank_id => 1, 
                             :category_rate_type => category_rate_type, 
                             :percent_rate => $3.to_f)
          
        end
      end
    end
    
  end
  
  namespace :bnc do
    
    task :delete => :environment do
      if RAILS_ENV == 'development' 
        
      else
        puts "Task can only run in dev mode"
      end      
    end
    
    desc 'load data from JS file'
    task :bnc_hypo_closed => :environment do    
      # HFA = Hypotheque Closed
      # HFA1  = 3 mois
      # HFA2  = 6 mois
      # HFA3  = 1 an
      # HFA4  = 2 ans
      # HFA5  = 3 ans
      # HFA6  = 4 ans
      # HFA7  = 5 ans
      # HFA10 = 6 ans
      # HFA8  = 7 ans
      # HFA9  = 10 ans
      h_conv = { 1 => 3, 2 => 6, 3 => 12, 4 => 24, 5 => 36, 6 => 48, 7 => 60, 10 => 72, 8 => 84, 9 => 120}

      source = "http://www.bnc.ca/bnc/cda/javascript/allrates/0,2697,divId-2_langId-2_navCode-9020_navCodeExTh--1,00.js"

      lines = open(source).read  
      data = {}
      type_name = "TauxFixeFerme";

      lines.each do |line| 
        rates_ar = Rate.new
        rate_type = RateType.new
        cat_rate_type = CategoryRateType.new
        
        line =~ /\baddRate\b\(\"HFA(.*)\"\,\"(.*)\"\,\".*\"\);/i
        if $2 != nil    
          # Verif if hypotheque exist
          name_cat = "hypotheque"
          cat_hypotheque = Category.find(:first, :conditions => {:name => name_cat})
          if !cat_hypotheque
            cat = Category.new 
            cat.name = name_cat
            cat.save
            cat_id = cat.id
          else
            cat_id = cat_hypotheque.id
          end
          #cat_id = verif_cat('hypotheque');

          data[$1] = $2  
          nb_month = h_conv[$1.to_i]

          # Verif if rate_type is already exist
          rate_type_exist = RateType.find(:first, :conditions => {:name => type_name, :nb_month => nb_month})
          if !rate_type_exist               
            # Save Rate Type
            rate_type = RateType.new
            begin
              rate_type.name = type_name
              rate_type.nb_month = nb_month
              rate_type.save
              rate_type_id = rate_type.id
            rescue
              puts "saveRateType method ERROR !"
            end
            #rate_type_id = saveRateType(type_name, nb_month/)
          else
            rate_type_id = rate_type_exist.id
          end        

          # Save Rates
          # rates_ar = Rate.new
          #go see Log4R
          begin            
            puts "-- bankid = 3"
            rates_ar.bank_id = 3  # Desjardins(1), BNC(3)

            puts "-- cat_rate_type"
            puts "--- cat_id = #{cat_id}"
            cat_rate_type.category_id = cat_id
            puts "--- rate_type_id = #{rate_type_id}"
            cat_rate_type.rate_type_id = rate_type_id
            cat_rate_type.save
            
            puts "-- cat_rate_type_id = #{cat_rate_type.id}"
            rates_ar.category_rate_type_id = cat_rate_type.id
            puts "-- rate = #{$2.to_f}"
            rates_ar.percent_rate = $2.to_f    
            rates_ar.save
          rescue
            puts "saveRates method ERROR !"
          end
          #(rate_type_id, bank_id, cat_id, rate)
          #saveRates(rate_type_id, 3, cat_id, $2.to_f)

        end 
      end

      # -- FOR TEST --
      data.each do |k,v|
        puts "#{h_conv[k.to_i]} -=> #{v}"
      end
      
      
    end
  end
end

