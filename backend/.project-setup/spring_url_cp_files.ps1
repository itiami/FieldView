# --- Config ---
$curl = "curl.exe"

# Modules to generate
$modules = @("api","audit","billing","common","identity","media","ocr","timelogs","workorders")

# Dependency presets
$depAll    = @("web","security","actuator","data-jpa","postgresql","validation","flyway","testcontainers")
$depApi    = @("web","security","actuator")
$depCommon = @("lombok","validation","configuration-processor")

# Common Spring Initializr params
$groupId        = "co.wali"
$artifactId     = "FieldWise"
$packageName    = "co.wali"
$type           = "gradle-project"
$language       = "java"
$javaVersion    = "17"
$bootVersion    = "4.0.0-M3"
$packaging      = "jar"
$version        = "0.1.0-SNAPSHOT"
$description    = "FieldWise Full Stack Application"

# Whether to delete the ZIP after extraction
$deleteZipAfter = $true

# --- Template sources (relative to repo root) ---
$templateRoot     = ".project-setup\module-setup"
$templateJavaDir  = Join-Path $templateRoot "java-example"
$templateFiles = @{
# root-level templates
    (Join-Path $templateRoot "build.gradle")      = "build.gradle"
    (Join-Path $templateRoot "gradle.properties") = "gradle.properties"
    (Join-Path $templateRoot "settings.gradle")   = "settings.gradle"
    # resources
    (Join-Path $templateRoot "application.properties") = "src\main\resources\application.properties"
}
$templateJavaFiles = @(
    "AppConfig.java",
    "Welcome.java"
)

function Copy-TemplatesIntoModule {
    param(
        [Parameter(Mandatory)]
        [string]$ModuleRoot,
        [Parameter(Mandatory)]
        [string]$PackageName
    )

    # Root + resources copies
    foreach ($kvp in $templateFiles.GetEnumerator()) {
        $src = $kvp.Key
        $dst = Join-Path $ModuleRoot $kvp.Value
        if (Test-Path $src) {
            $dstDir = Split-Path $dst -Parent
            if (-not (Test-Path $dstDir)) { New-Item -ItemType Directory -Force -Path $dstDir | Out-Null }
            Copy-Item -Path $src -Destination $dst -Force
            Write-Host "→ Copied $(Split-Path $src -Leaf) to $($kvp.Value)" -ForegroundColor DarkCyan
        }
    }

    # Java sources → src/main/java/<package path>
    $packagePath = ($PackageName -replace '\.', '\')
    $javaDstDir  = Join-Path $ModuleRoot ("src\main\java\" + $packagePath)
    if (-not (Test-Path $javaDstDir)) { New-Item -ItemType Directory -Force -Path $javaDstDir | Out-Null }

    foreach ($jf in $templateJavaFiles) {
        $src = Join-Path $templateJavaDir $jf
        if (Test-Path $src) {
            $dst = Join-Path $javaDstDir $jf
            Copy-Item -Path $src -Destination $dst -Force
            Write-Host "→ Copied $jf to src/main/java/$packagePath/" -ForegroundColor DarkCyan
        }
    }
}

function New-StarterZip {
    param(
        [Parameter(Mandatory)]
        [string]$Module
    )

    # Defaults for most modules
    $zipPath     = "modules/$Module.zip"
    $extractPath = "modules/$Module"
    $appName     = ($Module.Substring(0,1).ToUpper() + $Module.Substring(1))
    $deps        = $depAll

    switch ($Module) {
        "api" {
            $zipPath     = "apps/api.zip"
            $extractPath = "apps/api"
            $appName     = "App"
            $deps        = $depApi
        }
        "common" {
            $zipPath     = "modules/common.zip"
            $extractPath = "modules/common"
            $appName     = "Common"
            $deps        = $depCommon
        }
    }

    # Ensure output directory exists
    $outDir = Split-Path -Path $zipPath -Parent
    if (-not [string]::IsNullOrWhiteSpace($outDir)) {
        New-Item -ItemType Directory -Force -Path $outDir | Out-Null
    }

    # Comma-separated dependencies
    $depString = ($deps -join ",")

    Write-Host "Downloading $Module starter to $zipPath ..." -ForegroundColor Cyan

    # Download the project ZIP
    & $curl "https://start.spring.io/starter.zip" `
        -o $zipPath `
        -d "groupId=$groupId" `
        -d "artifactId=$artifactId" `
        -d "name=$appName" `
        -d "applicationName=$appName" `
        -d "packageName=$packageName" `
        -d "type=$type" `
        -d "language=$language" `
        -d "javaVersion=$javaVersion" `
        -d "bootVersion=$bootVersion" `
        -d "packaging=$packaging" `
        -d "version=$version" `
        -d "description=$description" `
        -d "dependencies=$depString"

    # Expand archive
    Write-Host "Extracting $Module to $extractPath ..." -ForegroundColor Yellow
    if (Test-Path $extractPath) { Remove-Item -Recurse -Force $extractPath }
    Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

    # Copy templates into the extracted project
    Write-Host "Applying templates to $Module ..." -ForegroundColor Yellow
    Copy-TemplatesIntoModule -ModuleRoot $extractPath -PackageName $packageName

    # Optionally delete ZIP
    if ($deleteZipAfter -and (Test-Path $zipPath)) { Remove-Item $zipPath -Force }

    Write-Host "✅ $Module ready at: $extractPath" -ForegroundColor Green
}

# --- Main ---
$modules | ForEach-Object { New-StarterZip -Module $_ }
