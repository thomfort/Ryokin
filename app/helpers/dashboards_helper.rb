module DashboardsHelper
  
  def showSeries(arr)
    str = ""
    str += "series: ["
    
    arr.each do |bankname, percent|
      str += "{
		  name: '#{bankname}',
			data: 
			 #{percent.inspect}      			
			},"
    end
    str += "]"      
  end  
  
  def getRatesByBank()
    arr = {}    
    rates_arr = []
    old_bid = 0
    
    rates = Rate.all()
    rates.each do |r|
      if r.bank_id != old_bid
        rates_arr = []
      end
      old_bid = r.bank_id
      
      arr[r.bank.name] = rates_arr.push(r.percent_rate.to_f)
    end
    
    showSeries(arr)    
  end
  
end
