namespace :scrapper do 
  namespace :desjardins do
    
    task :delete => :environment do
      if RAILS_ENV == 'development' 
        
      else
        puts "Task can only run in dev mode"
      end      
    end
    
    # Task order list
    task :load_all => [:closed_fixed]
    
    desc 'load data from the RSS'
    task :closed_fixed => :environment do


      # Get Rates of Desjardins
      #!/usr/bin/env ruby
      require "rss/1.0"
      require "rss/2.0"
      require "open-uri"
      
      source ="http://rss.desjardins.com/TauxFixeFerme"
      content = ""
      type_name = "TauxFixeFerme";

      open(source){|s| content = s.read}
      rss = RSS::Parser.parse(content, false)

      descriptions = rss.channel.item.description

      descriptions.each do |description|
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
        description =~ /(\d{1,3}) (mois|an|ans).*(\d{1,}\.\d{3,})/i

        if $1 != nil && $2 != nil && $3 != nil
          if $2 == 'mois'
            year = $1
          elsif $2 == 'an' || $2 == 'ans'
            year = $1.to_i * 12
          end
          puts "->#{year} - #{$3.to_f}"


          rate_type = RateType.create(:name => type_name, :nb_month => year)
          category_rate_type = CategoryRateType.create(:category_id => cat_id, :rate_type => rate_type)
          rate = Rate.create(:bank_id => 1, 
                             :category_rate_type => category_rate_type, 
                             :ratetype => rate_type,
                             :rate => $3.to_f)
          
        end
      end
    end
  end
end

