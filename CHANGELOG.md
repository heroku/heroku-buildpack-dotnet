# Changelog

## [Unreleased]

### Changed

- Detected process types are now only registered as launch processes when no Procfile is present. [#185](https://github.com/heroku/buildpacks-dotnet/pull/185)

### Added

- Enabled `libcnb`'s `trace` feature. [#184](https://github.com/heroku/buildpacks-dotnet/pull/184)

### Changed

- The .NET SDK inventory was updated with new download URLs for version 9.0 release artifacts. [#193](https://github.com/heroku/buildpacks-dotnet/pull/193)


## [v4] - 2025-01-16

### Added

- Support for .NET SDK versions: 8.0.112 (linux-amd64), 8.0.112 (linux-arm64), 8.0.308 (linux-amd64), 8.0.308 (linux-arm64), 8.0.405 (linux-amd64), 8.0.405 (linux-arm64), 9.0.102 (linux-amd64), 9.0.102 (linux-arm64). ([#34](https://github.com/heroku/heroku-buildpack-dotnet/pull/34))


## [v3] - 2024-12-04

### Added

- Support for .NET SDK versions: 9.0.101 (linux-amd64), 9.0.101 (linux-arm64). ([#25](https://github.com/heroku/heroku-buildpack-dotnet/pull/25))

## [v2] - 2024-11-30

### Changed

- The buildpack will now retry SDK downloads up to 5 times. ([#17](https://github.com/heroku/heroku-buildpack-dotnet/pull/17))

## [v1] - 2024-11-30

### Added

- Initial implementation.

[unreleased]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v4...main
[v4]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v3...v4
[v3]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v2...v3
[v2]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v1...v2
[v1]: https://github.com/heroku/heroku-buildpack-dotnet/releases/tag/v1
