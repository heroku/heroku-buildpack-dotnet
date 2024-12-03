![dotnet-buildpack-github-banner](https://github.com/user-attachments/assets/6f83e3de-ae3c-4e1c-b72e-60c69fc63041)

# Heroku Buildpack: .NET

[![CI](https://github.com/heroku/heroku-buildpack-dotnet/actions/workflows/ci.yml/badge.svg)](https://github.com/heroku/heroku-buildpack-dotnet/actions/workflows/ci.yml)

This is the official [Heroku buildpack](https://devcenter.heroku.com/articles/buildpacks) for .NET and ASP.NET Core applications.

## Getting Started

See the [Getting Started on Heroku with .NET](https://devcenter.heroku.com/articles/getting-started-with-dotnet) tutorial.

## Application Requirements

A solution file (e.g. `MySolution.sln`) or .NET project file (e.g. `*.csproj`, `*.vbproj` or `*.fsproj`) must be present in the root (top-level) directory of your app's source code. If the root directory contains both solution and project files, the solution file will be preferred for the build and publish process.

The buildpack support C#, Visual Basic and F# projects using the .NET and ASP.NET Core frameworks (version 8.0 and up).

## Using the Heroku .NET buildpack

It's suggested that you use the latest version of the release buildpack. You can set it using the `heroku-cli`.

```sh
heroku buildpacks:set heroku/dotnet
```

Your builds will always used the latest published release of the buildpack.

If you need to use the git url, you can use the `latest` tag to make sure you always have the latest release. **The `main` branch will always have the latest buildpack updates, but it does not correspond with a numbered release.**

```sh
heroku buildpacks:set https://github.com/heroku/heroku-buildpack-dotnet#latest -a my-app
```

## Locking to a buildpack version

Even though it's suggested to use the latest release, you may want to lock dependencies - including buildpacks - to a specific version.

First, find the version you want from
[the list of buildpack versions](https://github.com/heroku/heroku-buildpack-dotnet/tags).
Then, specify that version with `buildpacks:set`:

```
heroku buildpacks:set https://github.com/heroku/heroku-buildpack-dotnet#v1 -a my-app
```

## Documentation

For more information about using the .NET buildpack on Heroku, see these Dev Center articles:

- [Heroku .NET Support reference](https://devcenter.heroku.com/articles/dotnet-heroku-support-reference)
- [Getting Started on Heroku with .NET](https://devcenter.heroku.com/articles/getting-started-with-dotnet)
