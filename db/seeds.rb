banks = ["Desjardins", "ING"]

banks.each do |bank|
  Bank.create :name => bank  
end