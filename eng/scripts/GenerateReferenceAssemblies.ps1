param(
    [switch]$ci
)
$ErrorActionPreference = 'stop'

# GenAPI with `dotnet msbuild` doesn't consistently order attributes in Microsoft.AspNetCore.Mvc.TagHelpers.netcoreapp.cs
$msbuildEngine = 'vs'

Remove-Item variable:global:_BuildTool -ea Ignore
$repoRoot = Resolve-Path "$PSScriptRoot/../.."

& "$repoRoot\eng\common\msbuild.ps1" -ci:$ci "$repoRoot/eng/CodeGen.proj" `
    /t:GenerateReferenceSources `
    /bl:artifacts/log/genrefassemblies.binlog `
    /p:BuildNative=true
