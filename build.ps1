#$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

cd $scriptDir

$nodeVersion = node -v
$npmVersion = npm -v
$yarnVersion = yarn -v

Write-Output "-------------------------------------------"
Write-Output "Node: $nodeVersion, Npm: $npmVersion, Yarn: $yarnVersion"
Write-Output "-------------------------------------------"
Write-Output "Build project"
yarn build
Write-Output "-------------------------------------------"
Write-Output "Running Generator"

$schemaPath = Join-Path $scriptDir "samples/GitHub/input/GitHubSchema.json"
$outPath = Join-Path $scriptDir "samples/GitHub/output/OutTest/GitHubSchema.cs"
$queryPath = Join-Path  $scriptDir "samples/GitHub/input/*.graphql"
$templatePath = Join-Path $scriptDir "dist"

Write-Output "Schema Path: $schemaPath"
Write-Output "Output Path: $outPath"
Write-Output "Query Path: $queryPath"
Write-Output "Template Path: $templatePath"

yarn gql-gen --schema $schemaPath --template $templatePath --out $outPath $queryPath

Write-Output "-------------------------------------------"

#$outSlnProjectPath = Join-Path $scriptDir "samples/GitHub/output/OutTest.sln"

#$msbuild = "C:\Windows\Microsoft.NET\Framework\v4.0.30319\msbuild.exe"
#& $msbuild $outSlnProjectPath /target:Clean /target:Build