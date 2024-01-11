module UsualSuspect
  module VpnChecker
    def self.check_vpn(ip_address)
	  api_key = UsualSuspect.configuration.vpn_api_key
	  return false unless api_key

	  # Call IP2Location API
	  # Example URL (adjust according to IP2Location's API documentation)
	  url = "https://vpnapi.io/api/#{ip_address}?key=#{api_key}"

	  response = Net::HTTP.get(URI(url))
	  result = JSON.parse(response)

	  result
    rescue => e
      # Handle errors (e.g., network issues, invalid response)
      false
    end
  end
end
