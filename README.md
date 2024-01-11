# UsualSuspect: Your Rails Guardian Against Suspicious Logins and Behaviour

**UsualSuspect** is a cutting-edge Ruby gem specifically tailored for Rails applications, designed to fortify your user authentication system against an array of security threats. With a focus on real-time analysis and monitoring of user logins, UsualSuspect acts as a vigilant guard, identifying to unusual and potentially harmful activities, the response is up to you!

## Key Features

- **Password Change Monitoring**: Detects and logs suspicious password changes immediately after user login, providing an early warning system against account hijacking.
- **Geo-Velocity Tracking**: Utilizes advanced algorithms to calculate the speed of user movement based on login locations, flagging physically impossible travel scenarios that may indicate account compromises or account multi sharing.
- **VPN, Proxy and Tor Detection**: Leverages [vpnapi.io](https://vpnapi.io/api-documentation) robust database to identify logins from VPNs and proxies, enhancing your defense against masked IP addresses and location spoofing.
- **Session-Specific Analysis**: Each login session is treated uniquely, ensuring precise and context-aware security checks.
- **Configurable and Extendable**: Tailor the gem's behavior to your application's specific needs with customizable settings and thresholds.
- **Seamless Rails Integration**: Designed to integrate effortlessly with Rails applications, allowing you to add an extra layer of security with minimal setup.

## Installation

Add UsualSuspect to your application's Gemfile:

```ruby
gem 'usual_suspect'
```

Then execute:

```bash
$ bundle install
$ bundle exec rake usual_suspect:setup
$ rails db:migrate
```

Configure UsualSuspect in an initializer with your VPN API key from [vpnapi.io](https://vpnapi.io/api-documentation):

```ruby
UsualSuspect.configure do |config|
  config.vpn_api_key = 'YOUR_API_KEY'
end
```

## Usage

Add this to your User model:

```ruby
include UsualSuspect::UserExtension

has_many :usual_suspect_events
```

In your sessions controller add:

```ruby
include UsualSuspect::SessionsControllerExtension
```

And when your session is created and you have a current_user available then add this line:

```
track_usual_suspect_login
```

To check for suspicious password change after login you can add this in your password update controller method:
```	
current_user.check_for_suspicious_password_change(session[:usual_suspect_session_token])
```

When the user logs in, it will create a new record in the table `UsualSuspectEvent`, and depending on the fields you can decide if you should block that user account, depending on your organization requirements.

```ruby
[#<UsualSuspectEvent:0x00007fcdd8319680
  id: 1,
  user_id: 2,
  last_sign_in_at: nil,
  sign_in_at: Thu, 11 Jan 2024 00:56:59.231569000 UTC +00:00,
  password_change_after_login: nil,
  geovelocity_failed: true,
  using_vpn: true,
  using_proxy: false,
  using_tor: false,
  sign_in_ip: "192.145.39.9",
  city: "Madrid",
  country: "ES",
  latitude: "40.4165",
  longitude: "-3.7026",
  session_token: "[FILTERED]",
  created_at: Thu, 11 Jan 2024 00:56:59.232648000 UTC +00:00,
  updated_at: Thu, 11 Jan 2024 00:56:59.232648000 UTC +00:00>]
```

## Contributing

Contributions are more than welcome! If you have ideas for improvements or encounter any issues, please feel free to fork the repository and submit a pull request or an issue and I'll find the time to fix it.

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Acknowledgements

- [vpnapi.io](https://vpnapi.io/api-documentation):
- [Geocoder](https://github.com/alexreisner/geocoder)

Elevate your Rails application's security to the next level with UsualSuspect!
