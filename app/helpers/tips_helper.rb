module TipsHelper
  
  def listip
    Tip.find(:last)
  end
  
end
