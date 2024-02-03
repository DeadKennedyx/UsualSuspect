# Changelog

All notable changes to the `UsualSuspect` gem will be documented in this file.

## [Unreleased]

- Additional security features and enhancements.

## [1.0.0] - 2024-02-03
### Added
- Device Fingerprinting
- New Device tracking

## [0.1.0] - 2024-01-08
### Added

- **Suspicious Password Change Detection**: Automatically monitors and logs instances where a password is changed shortly after logging in, helping to identify potential account hijacking.
- **Geo-Velocity Tracking**: Implements a check for the physical feasibility of user movement between consecutive logins based on login locations and timestamps.
- **VPN and Proxy Detection**: Integrates with the IP2Location service to identify logins from VPNs and proxies, flagging potentially masked IP addresses and location spoofing.
- **Session-Specific Event Logging**: Each login session is now uniquely identified and tracked, allowing for more precise security monitoring and reducing the likelihood of false positives in security event detection.
- **Customizable Configuration**: Allows users to set their IP2Location API keys and configure other settings for tailored security measures.
- **Rails Session Integration**: Utilizes Rails session mechanism to track and associate user activities with specific login sessions.
- **Improved Documentation**: Expanded README and in-code documentation for easier setup and usage.

### Changed

- **Refactored Event Logging**: Transitioned to a model where each login event is stored as a separate record for more accurate tracking.
- **Enhanced Security Checks**: Updated methods for more precise detection of suspicious activities, including the use of latitude and longitude for geo-velocity calculations.

