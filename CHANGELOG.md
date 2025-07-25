# Changelog

## [Unreleased]


## [v26] - 2025-07-18

### Added

- Support for .NET SDK versions: 9.0.303 (linux-amd64), 9.0.303 (linux-arm64). ([#103](https://github.com/heroku/heroku-buildpack-dotnet/pull/103))

## [v25] - 2025-07-16

### Changed

- `bin/report` output containing single quotes is now properly escaped. ([#101](https://github.com/heroku/heroku-buildpack-dotnet/pull/101))

## [v24] - 2025-07-15

### Added

- Implemented the `bin/report` build report API. ([#97](https://github.com/heroku/heroku-buildpack-dotnet/pull/97))

## [v23] - 2025-07-08

### Added

- Support for .NET SDK versions: 8.0.118 (linux-amd64), 8.0.118 (linux-arm64), 8.0.315 (linux-amd64), 8.0.315 (linux-arm64), 8.0.412 (linux-amd64), 8.0.412 (linux-arm64), 9.0.108 (linux-amd64), 9.0.108 (linux-arm64), 9.0.302 (linux-amd64), 9.0.302 (linux-arm64). ([#98](https://github.com/heroku/heroku-buildpack-dotnet/pull/98))

## [v22] - 2025-06-24

### Removed

- A warning about breaking launch process type name changes is no longer written to the buildpack log output. ([#92](https://github.com/heroku/heroku-buildpack-dotnet/pull/92))

### Changed

- Improved the error messages shown if there is a networking or server related error downloading buildpack dependencies. ([#91](https://github.com/heroku/heroku-buildpack-dotnet/pull/91))

## [v21] - 2025-06-12

### Added

- Support for .NET SDK versions: 8.0.117 (linux-amd64), 8.0.117 (linux-arm64), 8.0.314 (linux-amd64), 8.0.314 (linux-arm64), 8.0.411 (linux-amd64), 8.0.411 (linux-arm64), 9.0.107 (linux-amd64), 9.0.107 (linux-arm64), 9.0.205 (linux-amd64), 9.0.205 (linux-arm64), 9.0.301 (linux-amd64), 9.0.301 (linux-arm64). ([#88](https://github.com/heroku/heroku-buildpack-dotnet/pull/88))

## [v20] - 2025-05-26

### Added

- Support for .NET SDK versions: 8.0.313 (linux-amd64), 8.0.313 (linux-arm64), 8.0.410 (linux-amd64), 8.0.410 (linux-arm64). ([#85](https://github.com/heroku/heroku-buildpack-dotnet/pull/85))

## [v19] - 2025-05-14

### Added

- Support for .NET SDK versions: 8.0.116 (linux-amd64), 8.0.116 (linux-arm64), 8.0.312 (linux-amd64), 8.0.312 (linux-arm64), 8.0.409 (linux-amd64), 8.0.409 (linux-arm64), 9.0.106 (linux-amd64), 9.0.106 (linux-arm64), 9.0.204 (linux-amd64), 9.0.204 (linux-arm64), 9.0.300 (linux-amd64), 9.0.300 (linux-arm64). ([#83](https://github.com/heroku/heroku-buildpack-dotnet/pull/83))

## [v18] - 2025-05-09

### Changed

- Enhance error message for missing project references in solution files to include common causes and detailed resolution steps. ([#81](https://github.com/heroku/heroku-buildpack-dotnet/pull/81))
- The .NET SDK inventory was updated with new release artifact download URLs. ([#81](https://github.com/heroku/heroku-buildpack-dotnet/pull/81))

## [v17] - 2025-04-17

### Changed

- The buildpack now lowercases launch process type names, and replaces spaces, dots (`.`), and underscores (`_`) with hyphens (`-`) for broader compatibility. ([#77](https://github.com/heroku/heroku-buildpack-dotnet/pull/77))

## [v16] - 2025-04-09

### Added

- Support for .NET SDK versions: 8.0.115 (linux-amd64), 8.0.115 (linux-arm64), 8.0.311 (linux-amd64), 8.0.311 (linux-arm64), 8.0.408 (linux-amd64), 8.0.408 (linux-arm64), 9.0.105 (linux-amd64), 9.0.105 (linux-arm64), 9.0.203 (linux-amd64), 9.0.203 (linux-arm64). ([#75](https://github.com/heroku/heroku-buildpack-dotnet/pull/75))

## [v15] - 2025-03-25

### Changed

- The buildpack will now set the process type `web` for a single web application within a solution. When a solution contains multiple web applications, the process type is derived from the project assembly name. ([#71](https://github.com/heroku/heroku-buildpack-dotnet/pull/71))

## [v14] - 2025-03-22

### Changed

- The buildpack now sanitizes process type names (based on project assembly names) by filtering out invalid characters. ([#68](https://github.com/heroku/heroku-buildpack-dotnet/pull/68))
- Default process types with paths containing special characters (including spaces) are now properly quoted. ([#68](https://github.com/heroku/heroku-buildpack-dotnet/pull/68))
- The default test command executed by Heroku CI now properly handles solution/project filenames containing special characters (including spaces). ([#68](https://github.com/heroku/heroku-buildpack-dotnet/pull/68))

## [v13] - 2025-03-19

### Added

- Support for .NET SDK versions: 9.0.202 (linux-amd64), 9.0.202 (linux-arm64). ([#65](https://github.com/heroku/heroku-buildpack-dotnet/pull/65))

## [v12] - 2025-03-18

### Changed

- The buildpack will now also restore .NET tools for Heroku CI. ([#63](https://github.com/heroku/heroku-buildpack-dotnet/pull/63))
- The log output now reflects whether a project or solution file was used for SDK version detection. ([#63](https://github.com/heroku/heroku-buildpack-dotnet/pull/63))

## [v11] - 2025-03-13

### Added

- Support for Heroku CI. ([#58](https://github.com/heroku/heroku-buildpack-dotnet/pull/58))

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

[unreleased]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v26...main
[v26]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v25...v26
[v25]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v24...v25
[v24]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v23...v24
[v23]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v22...v23
[v22]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v21...v22
[v21]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v20...v21
[v20]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v19...v20
[v19]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v18...v19
[v18]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v17...v18
[v17]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v16...v17
[v16]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v15...v16
[v15]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v14...v15
[v14]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v13...v14
[v13]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v12...v13
[v12]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v11...v12
[v11]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v10...v11
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
