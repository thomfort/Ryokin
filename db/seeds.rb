Bank.delete_all
#execute 'ALTER TABLE banks AUTO_INCREMENT = 1'
AdvisorType.delete_all
#execute 'ALTER TABLE advisor_types AUTO_INCREMENT = 1'
Advisor.delete_all
#execute 'ALTER TABLE advisors AUTO_INCREMENT = 1'

advisor_firstname = { 1 => "Lance", 2 => "Max", 3 => "Ashlee", 4 => "Cody", 5 => "Maricela" }
advisor_lastname =  { 1 => "Billips", 2 => "Sturgell", 3 => "Chagnon", 4 => "Hanning", 5 => "Byfield" }

# Generate Bank data's
banks = { 1 => "Desjardins", 2 => "ING", 3 => "Banque National", 4 => "RBC", 5 => "TD Canada"}

banks.each do |id, bank|
  puts "ID => #{id}"
  puts "Bank => #{bank}"
  Bank.create :id => id, :name => bank  
end

# Generate Advisor Type
advisor_types = {1 => "Manager", 2 => "General", 3 => "Conseiller", 4 => "Preposer", 5 => "Secretaire"}

advisor_types.each do |k,type|
  AdvisorType.create :id => k, :name => type
end

# Generate Advisor
(1..5).each do |a|
  puts "===> va -> #{a}"
  puts "===> at -> #{rand(5)}"
  Advisor.create  :advisor_type_id => a, 
                  :bank_id => a, 
                  :lastname => advisor_lastname[a], 
                  :firstname => advisor_firstname[a]
end