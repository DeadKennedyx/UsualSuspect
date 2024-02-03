# UsualSuspect: Your Rails Guardian Against Suspicious Logins and Behaviour

**UsualSuspect** is a Ruby gem specifically tailored for Rails applications, designed to fortify your user authentication system against an array of security threats. With a focus on real-time analysis and monitoring of user logins, UsualSuspect acts as a vigilant guard, identifying unusual and potentially harmful activities, the response is up to you!

## Key Features

- **Password Change Monitoring**: Detects and logs suspicious password changes immediately after user login, providing an early warning system against account hijacking.
- **Geo-Velocity Tracking**: Utilizes algorithms to calculate the speed of user movement based on login locations, flagging physically impossible travel scenarios that may indicate account compromises or account multi sharing.
- **Device Fingerprinting**: Device fingerprinting support.
- **New Device Detection**: check saved fingerprints to detect new devices.
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
The free tier on [vpnapi.io](https://vpnapi.io/api-documentation) allows for 1k requests per day, you'll need to upgrade tier if you want more, if you want to make this gem to be available to use in more services feel free to open a pull request or an issue and I'll add support for more services!

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
#### Suspicious password change:

To check for suspicious password change after login you can add this in the controller and method where the user password is updated:
```	
current_user.check_for_suspicious_password_change(session[:usual_suspect_session_token])
```
#### Device fingerprinting:
To add device fingerprinting you will need to send device_info parameters in your login form. you can get device_info this way with javascript, usual_suspect will take care of the rest.

```javascript
var formId = 'your_login_form_id'; // Replace with your actual form ID
var form = document.getElementById(formId);

var deviceInfo = {
    language: navigator.language,
    timezone: Intl.DateTimeFormat().resolvedOptions().timeZone,
    screen_width: screen.width,
    screen_height: screen.height,
    colorDepth: screen.colorDepth,
    sessionStorage: !!window.sessionStorage,
    localStorage: !!window.localStorage,
    cookiesEnabled: navigator.cookieEnabled,
    deviceMemory: navigator.deviceMemory || 'unknown',
    hardwareConcurrency: navigator.hardwareConcurrency,
};

function createAndAppendInput(name, value) {
    var input = document.createElement('input');
    input.type = 'hidden';
    input.name = 'device_info[' + name + ']';
    input.value = value;
    form.append(input);
}

for (var key in deviceInfo) {
    createAndAppendInput(key, deviceInfo[key]);
}
```
#### Data saved:
When the user logs in, it will create a new record in the table `UsualSuspectEvent`, and depending on the fields you can decide if you should block that user account.
Also when the user changes password it will update the `password_change_after_login` to true if the password change was before 5 minutes of being logged in.

UsualSuspectEvent Table:
```ruby
#<UsualSuspectEvent:0x00007fdef36c3c00
 id: 18,
 user_id: 2,
 last_sign_in_at: nil,
 sign_in_at: Thu, 25 Jan 2024 01:42:13.557680000 UTC +00:00,
 password_change_after_login: true,
 geovelocity_failed: true,
 using_vpn: true,
 using_proxy: false,
 using_tor: false,
 new_device: false,
 sign_in_ip: "xxx.xxx.xxx.xx",
 city: "Madrid",
 country: "ES",
 latitude: "xx.xxxx",
 longitude: "-xxx.xxxx",
 session_token: "[FILTERED]",
 device_fingerprint: "c18ab96a22bece029c71a7229b48234786b3055880eeda6091942ef5cd136",
 created_at: Thu, 25 Jan 2024 01:42:13.562592000 UTC +00:00,
 updated_at: Thu, 25 Jan 2024 01:42:13.562592000 UTC +00:00>
```

## Contributing

If you are cloning or using the gem, give me a little star :)!

Contributions are more than welcome! If you have ideas for improvements or encounter any issues, please feel free to fork the repository and submit a pull request or an issue and I'll find the time to fix it.

## License

Distributed under the MIT License. See `LICENSE` for more information.

## Acknowledgements

- [vpnapi.io](https://vpnapi.io/api-documentation)
- [Geocoder](https://github.com/alexreisner/geocoder)

Elevate your Rails application's security to the next level with UsualSuspect!
