Bank.delete_all
Rate.delete_all
RateType.delete_all
Category.delete_all
CategoryRateType.delete_all


banks = { 1 => "Desjardins", 2 => "ING", 3 => "BNC"}

banks.each do |id,bank|
  puts "ID => #{id}"
  puts "Bank => #{bank}"
  Bank.create :id => id, :name => bank  
end