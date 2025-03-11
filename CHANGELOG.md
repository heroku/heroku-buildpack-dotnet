# Changelog

## [Unreleased]


## [v10] - 2025-03-11

### Added

- Support for .NET SDK versions: 8.0.114 (linux-amd64), 8.0.114 (linux-arm64), 8.0.310 (linux-amd64), 8.0.310 (linux-arm64), 8.0.407 (linux-amd64), 8.0.407 (linux-arm64), 9.0.104 (linux-amd64), 9.0.104 (linux-arm64), 9.0.201 (linux-amd64), 9.0.201 (linux-arm64). ([#54](https://github.com/heroku/heroku-buildpack-dotnet/pull/54))

## [v9] - 2025-03-10

### Changed

- The .NET SDK inventory was updated with new download URLs for version 9.0 release artifacts. ([#52](https://github.com/heroku/heroku-buildpack-dotnet/pull/52))
- The buildpack will now skip NuGet package XML doc extraction when running `dotnet publish`. ([#52](https://github.com/heroku/heroku-buildpack-dotnet/pull/52))
- The build configuration is no longer written to the log before the `dotnet publish` command (which still includes the build configuration value when specified). ([#52](https://github.com/heroku/heroku-buildpack-dotnet/pull/52))

## [v8] - 2025-03-10

### Changed

- The `sdk` element in detected `global.json` files is no longer required. The SDK version to install is now inferred from the solution/project files when `global.json` doesn't define SDK configuration. ([#49](https://github.com/heroku/heroku-buildpack-dotnet/pull/49))
- The buildpack will now set `--artifacts-path` to a temporary directory during `dotnet publish`. This change reduces the number of unused, duplicated and/or intermediate files in the app directory. Published output for each project is still written to the same location relative to the the project directory (`bin/publish`, as configured using the `PublishDir` property). ([#49](https://github.com/heroku/heroku-buildpack-dotnet/pull/49))

## [v7] - 2025-02-12

### Added

- The buildpack will now restore .NET tools when a tool manifest file is detected. ([#43](https://github.com/heroku/heroku-buildpack-dotnet/pull/43))

## [v6] - 2025-02-12

### Changed

- The .NET SDK inventory was updated with new download URLs for version 9.0 release artifacts. ([#41](https://github.com/heroku/heroku-buildpack-dotnet/pull/41))

### Added

- Support for .NET SDK versions: 8.0.113 (linux-amd64), 8.0.113 (linux-arm64), 8.0.309 (linux-amd64), 8.0.309 (linux-arm64), 8.0.406 (linux-amd64), 8.0.406 (linux-arm64), 9.0.103 (linux-amd64), 9.0.103 (linux-arm64), 9.0.200 (linux-amd64), 9.0.200 (linux-arm64). ([#41](https://github.com/heroku/heroku-buildpack-dotnet/pull/41))

## [v5] - 2025-02-10

### Changed

- Detected process types are now only registered as default processes when no Procfile is present. ([#39](https://github.com/heroku/heroku-buildpack-dotnet/pull/39))
- The .NET SDK inventory was updated with new download URLs for version 9.0 release artifacts. ([#39](https://github.com/heroku/heroku-buildpack-dotnet/pull/39))

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

[unreleased]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v10...main
[v10]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v9...v10
[v9]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v8...v9
[v8]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v7...v8
[v7]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v6...v7
[v6]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v5...v6
[v5]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v4...v5
[v4]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v3...v4
[v3]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v2...v3
[v2]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v1...v2
[v1]: https://github.com/heroku/heroku-buildpack-dotnet/releases/tag/v1
