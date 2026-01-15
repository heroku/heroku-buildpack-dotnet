# Changelog

## [Unreleased]

### Fixed

- The .NET SDK inventory was updated with correct checksum values for version 9.0.113 release artifacts. ([#375](https://github.com/heroku/buildpacks-dotnet/pull/375))


## [v44] - 2026-01-13

### Added

- Support for .NET SDK versions: 8.0.123, 8.0.417, 9.0.113, 9.0.309, 10.0.102. ([#166](https://github.com/heroku/heroku-buildpack-dotnet/pull/166))

## [v43] - 2026-01-09

### Added

- Added metrics for launch process detection errors. ([#164](https://github.com/heroku/heroku-buildpack-dotnet/pull/164))

## [v42] - 2026-01-08

### Changed

- Improved error handling when downloading and extracting the .NET CNB from GitHub. ([#158](https://github.com/heroku/heroku-buildpack-dotnet/pull/158))

### Fixed

- Launch process detection now skips projects if the published executable is missing from the expected path. ([#162](https://github.com/heroku/heroku-buildpack-dotnet/pull/162))

## [v41] - 2025-12-13

### Added

- Support for configuring the target framework using `Directory.Build.props`. ([#156](https://github.com/heroku/heroku-buildpack-dotnet/pull/156))
- Support for configuring the `AssemblyName` property in file-based apps. ([#156](https://github.com/heroku/heroku-buildpack-dotnet/pull/156))

### Fixed

- Fixed an issue where leading whitespace in file-based app configuration values was incorrectly included. ([#156](https://github.com/heroku/heroku-buildpack-dotnet/pull/156))

## [v40] - 2025-12-09

### Changed

- Improved `global.json` parsing to validate `rollForward` policy values and provide clearer error messages for invalid SDK versions. ([#154](https://github.com/heroku/heroku-buildpack-dotnet/pull/154))

### Added

- Support for .NET SDK versions: 10.0.101. ([#154](https://github.com/heroku/heroku-buildpack-dotnet/pull/154))

## [v39] - 2025-12-04

### Changed

- Improved error handling when configured solution file doesn't exist, has an invalid extension, or is not a simple filename. ([#152](https://github.com/heroku/heroku-buildpack-dotnet/pull/152))

### Fixed

- `global.json` SDK version matching now correctly respects .NET SDK feature band boundaries when using `patch` or `latestPatch` roll-forward policies. ([#152](https://github.com/heroku/heroku-buildpack-dotnet/pull/152))
- The default `global.json` roll-forward policy now defaults to `patch`. ([#152](https://github.com/heroku/heroku-buildpack-dotnet/pull/152))

## [v38] - 2025-11-20

### Added

- Support for .NET SDK versions: 9.0.308. ([#146](https://github.com/heroku/heroku-buildpack-dotnet/pull/146))

## [v37] - 2025-11-11

### Added

- Support for .NET SDK versions: 8.0.122, 8.0.319, 8.0.416, 9.0.112, 9.0.307, 10.0.100. ([#144](https://github.com/heroku/heroku-buildpack-dotnet/pull/144))
- Support for .NET 10 file-based apps. ([#142](https://github.com/heroku/heroku-buildpack-dotnet/pull/142), [#143](https://github.com/heroku/heroku-buildpack-dotnet/pull/143))

### Changed

- Refactored .NET project file parsing to better align with MSBuild behavior and project file semantics. ([#143](https://github.com/heroku/heroku-buildpack-dotnet/pull/143))

## [v36] - 2025-10-21

### Added

- Support for the SLNX (`.slnx`) solution file format. ([#138](https://github.com/heroku/heroku-buildpack-dotnet/pull/138), [#135](https://github.com/heroku/heroku-buildpack-dotnet/pull/135))

## [v35] - 2025-10-14

### Added

- Support for .NET SDK versions: 8.0.121, 8.0.318, 8.0.415, 9.0.111, 9.0.306, 10.0.100-rc.2.25502.107. ([#136](https://github.com/heroku/heroku-buildpack-dotnet/pull/136))

## [v34] - 2025-10-04

### Changed

- Enhanced `dotnet` command failure error messages with clearer guidance and NuGet status link for troubleshooting. ([#133](https://github.com/heroku/heroku-buildpack-dotnet/pull/133))

## [v33] - 2025-09-17

### Changed

- Improved launch process detection with robust `launch.toml` parsing. ([#124](https://github.com/heroku/heroku-buildpack-dotnet/pull/124))

## [v32] - 2025-09-12

### Added

- Support for configuring the solution file to build and publish via `SOLUTION_FILE` environment variable. ([#127](https://github.com/heroku/heroku-buildpack-dotnet/pull/127))

### Changed

- Detection failure error messages now include root directory listing and comprehensive troubleshooting guidance. ([#126](https://github.com/heroku/heroku-buildpack-dotnet/pull/126))

## [v31] - 2025-09-09

### Added

- Support for .NET SDK versions: 8.0.120, 8.0.317, 8.0.414, 9.0.110, 9.0.305, 10.0.100-rc.1.25451.107. ([#122](https://github.com/heroku/heroku-buildpack-dotnet/pull/122))


## [v30] - 2025-09-09

### Added

- Support for configuring the solution to build and publish in `project.toml`. ([#120](https://github.com/heroku/heroku-buildpack-dotnet/pull/120))

### Changed

- The buildpack now requires an explicitly configured solution file when multiple solutions are present in the root directory. ([#120](https://github.com/heroku/heroku-buildpack-dotnet/pull/120))

### Fixed

- Detection failure error messages are now correctly displayed in build logs. ([#115](https://github.com/heroku/heroku-buildpack-dotnet/pull/115))

## [v29] - 2025-08-28

### Added

- Support for customizing the default build configuration and MSBuild verbosity level with a `project.toml` file. ([#111](https://github.com/heroku/heroku-buildpack-dotnet/pull/111))

### Changed

- The buildpack now supports projects using .NET 10.0 preview releases (without custom `global.json` config). ([#111](https://github.com/heroku/heroku-buildpack-dotnet/pull/111))

## [v28] - 2025-08-14

### Added

- Support for .NET SDK versions: 10.0.100-preview.1.25120.13, 10.0.100-preview.2.25164.34, 10.0.100-preview.3.25201.16, 10.0.100-preview.4.25258.110, 10.0.100-preview.5.25277.114, 10.0.100-preview.6.25358.103, 10.0.100-preview.7.25380.108. ([#109](https://github.com/heroku/heroku-buildpack-dotnet/pull/109))

## [v27] - 2025-08-05

### Added

- Support for .NET SDK versions: 8.0.119, 8.0.316, 8.0.413, 9.0.109, 9.0.304. ([#107](https://github.com/heroku/heroku-buildpack-dotnet/pull/107))

## [v26] - 2025-07-18

### Added

- Support for .NET SDK versions: 9.0.303. ([#103](https://github.com/heroku/heroku-buildpack-dotnet/pull/103))

## [v25] - 2025-07-16

### Changed

- `bin/report` output containing single quotes is now properly escaped. ([#101](https://github.com/heroku/heroku-buildpack-dotnet/pull/101))

## [v24] - 2025-07-15

### Added

- Implemented the `bin/report` build report API. ([#97](https://github.com/heroku/heroku-buildpack-dotnet/pull/97))

## [v23] - 2025-07-08

### Added

- Support for .NET SDK versions: 8.0.118, 8.0.315, 8.0.412, 9.0.108, 9.0.302. ([#98](https://github.com/heroku/heroku-buildpack-dotnet/pull/98))

## [v22] - 2025-06-24

### Removed

- A warning about breaking launch process type name changes is no longer written to the buildpack log output. ([#92](https://github.com/heroku/heroku-buildpack-dotnet/pull/92))

### Changed

- Improved the error messages shown if there is a networking or server related error downloading buildpack dependencies. ([#91](https://github.com/heroku/heroku-buildpack-dotnet/pull/91))

## [v21] - 2025-06-12

### Added

- Support for .NET SDK versions: 8.0.117, 8.0.314, 8.0.411, 9.0.107, 9.0.205, 9.0.301. ([#88](https://github.com/heroku/heroku-buildpack-dotnet/pull/88))

## [v20] - 2025-05-26

### Added

- Support for .NET SDK versions: 8.0.313, 8.0.410. ([#85](https://github.com/heroku/heroku-buildpack-dotnet/pull/85))

## [v19] - 2025-05-14

### Added

- Support for .NET SDK versions: 8.0.116, 8.0.312, 8.0.409, 9.0.106, 9.0.204, 9.0.300. ([#83](https://github.com/heroku/heroku-buildpack-dotnet/pull/83))

## [v18] - 2025-05-09

### Changed

- Enhance error message for missing project references in solution files to include common causes and detailed resolution steps. ([#81](https://github.com/heroku/heroku-buildpack-dotnet/pull/81))
- The .NET SDK inventory was updated with new release artifact download URLs. ([#81](https://github.com/heroku/heroku-buildpack-dotnet/pull/81))

## [v17] - 2025-04-17

### Changed

- The buildpack now lowercases launch process type names, and replaces spaces, dots (`.`), and underscores (`_`) with hyphens (`-`) for broader compatibility. ([#77](https://github.com/heroku/heroku-buildpack-dotnet/pull/77))

## [v16] - 2025-04-09

### Added

- Support for .NET SDK versions: 8.0.115, 8.0.311, 8.0.408, 9.0.105, 9.0.203. ([#75](https://github.com/heroku/heroku-buildpack-dotnet/pull/75))

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

- Support for .NET SDK versions: 9.0.202. ([#65](https://github.com/heroku/heroku-buildpack-dotnet/pull/65))

## [v12] - 2025-03-18

### Changed

- The buildpack will now also restore .NET tools for Heroku CI. ([#63](https://github.com/heroku/heroku-buildpack-dotnet/pull/63))
- The log output now reflects whether a project or solution file was used for SDK version detection. ([#63](https://github.com/heroku/heroku-buildpack-dotnet/pull/63))

## [v11] - 2025-03-13

### Added

- Support for Heroku CI. ([#58](https://github.com/heroku/heroku-buildpack-dotnet/pull/58))

## [v10] - 2025-03-11

### Added

- Support for .NET SDK versions: 8.0.114, 8.0.310, 8.0.407, 9.0.104, 9.0.201. ([#54](https://github.com/heroku/heroku-buildpack-dotnet/pull/54))

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

- Support for .NET SDK versions: 8.0.113, 8.0.309, 8.0.406, 9.0.103, 9.0.200. ([#41](https://github.com/heroku/heroku-buildpack-dotnet/pull/41))

## [v5] - 2025-02-10

### Changed

- Detected process types are now only registered as default processes when no Procfile is present. ([#39](https://github.com/heroku/heroku-buildpack-dotnet/pull/39))
- The .NET SDK inventory was updated with new download URLs for version 9.0 release artifacts. ([#39](https://github.com/heroku/heroku-buildpack-dotnet/pull/39))

## [v4] - 2025-01-16

### Added

- Support for .NET SDK versions: 8.0.112, 8.0.308, 8.0.405, 9.0.102. ([#34](https://github.com/heroku/heroku-buildpack-dotnet/pull/34))

## [v3] - 2024-12-04

### Added

- Support for .NET SDK versions: 9.0.101. ([#25](https://github.com/heroku/heroku-buildpack-dotnet/pull/25))

## [v2] - 2024-11-30

### Changed

- The buildpack will now retry SDK downloads up to 5 times. ([#17](https://github.com/heroku/heroku-buildpack-dotnet/pull/17))

## [v1] - 2024-11-30

### Added

- Initial implementation.

[unreleased]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v44...main
[v44]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v43...v44
[v43]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v42...v43
[v42]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v41...v42
[v41]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v40...v41
[v40]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v39...v40
[v39]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v38...v39
[v38]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v37...v38
[v37]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v36...v37
[v36]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v35...v36
[v35]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v34...v35
[v34]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v33...v34
[v33]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v32...v33
[v32]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v31...v32
[v31]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v30...v31
[v30]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v29...v30
[v29]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v28...v29
[v28]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v27...v28
[v27]: https://github.com/heroku/heroku-buildpack-dotnet/compare/v26...v27
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
