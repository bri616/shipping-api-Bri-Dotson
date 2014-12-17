include ActiveMerchant::Shipping

$ups = UPS.new(:login => 'auntjudy', :password => 'secret', :key => ENV["UPS_KEY"])
