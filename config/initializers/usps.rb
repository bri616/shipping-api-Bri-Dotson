include ActiveMerchant::Shipping

$usps = USPS.new(:login => ENV["USPS_LOGIN"])
