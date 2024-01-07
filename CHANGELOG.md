# Changelog

All notable changes to "UsualSuspect" will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

- Additional security features such as rooted device detection, VPN/proxy usage, geo velocity, etc.

## [0.1.0] - 2024-01-08
### Added
- Initial release of the gem.
- UserExtension module to track and log suspicious password changes.
- Rake task for generating necessary migrations for users.
- Mocks for `save` and `encrypted_password_changed?` methods in RSpec tests.
- Basic configuration and setup instructions.
- Gemspec with a valid homepage_uri link.

### Fixed
- Gemspec validation issues related to metadata 'homepage_uri'.

### Changed
- Discussion and clarification on the `after_update` callback behavior, particularly related to `changed?` and `saved_change_to_attribute?` methods.
