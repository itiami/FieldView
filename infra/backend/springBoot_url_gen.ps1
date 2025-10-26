# Ensure using real curl
$curl = "curl.exe"

# Common Initializr params
$groupId     = "co.wali"
$javaVersion = "21"
$bootVersion = "3.3.4"      # pick your target
$type        = "gradle-project"
$packaging   = "jar"
$language    = "java"
$commonFlags = "--fail -sS --retry 3 --create-dirs"

# Helper to join dependency arrays into comma list
function Join-Deps([string[]]$deps) {
    return ($deps -join ",")
}

# Define module matrix
$modules = @(
    @{ out="apps\api.zip";       artifact="FieldWise";  package="co.wali";             deps=@("web","security","actuator") }, # keep API thin; add gateways later
    @{ out="modules\common.zip"; artifact="common";     package="co.wali.common";      deps=@("lombok","validation","configuration-processor") },

    @{ out="modules\identity.zip";   artifact="identity";   package="co.wali.identity";   deps=@("web","security","actuator","data-jpa","postgresql","validation","flyway","testcontainers") },
    @{ out="modules\workorders.zip"; artifact="workorders"; package="co.wali.workorders"; deps=@("web","security","actuator","data-jpa","postgresql","validation","flyway","testcontainers") },
    @{ out="modules\timelogs.zip";   artifact="timelogs";   package="co.wali.timelogs";   deps=@("web","security","actuator","data-jpa","postgresql","validation","flyway","testcontainers") },
    @{ out="modules\billing.zip";    artifact="billing";    package="co.wali.billing";    deps=@("web","security","actuator","data-jpa","postgresql","validation","flyway","testcontainers") },
    @{ out="modules\audit.zip";      artifact="audit";      package="co.wali.audit";      deps=@("web","security","actuator","data-jpa","postgresql","validation","flyway","testcontainers") },

    @{ out="modules\media.zip"; artifact="media"; package="co.wali.media"; deps=@("web","security","actuator","data-mongodb","validation","testcontainers") },
    @{ out="modules\ocr.zip";   artifact="ocr";   package="co.wali.ocr";   deps=@("web","security","actuator","data-mongodb","validation","testcontainers") }
)

# Build requests
foreach ($m in $modules) {
    $deps = Join-Deps $m.deps
    & $curl $commonFlags `
    "https://start.spring.io/starter.zip" `
    -o $m.out `
    -d "type=$type" `
    -d "language=$language" `
    -d "packaging=$packaging" `
    -d "groupId=$groupId" `
    -d "artifactId=$($m.artifact)" `
    -d "packageName=$($m.package)" `
    -d "javaVersion=$javaVersion" `
    -d "bootVersion=$bootVersion" `
    -d "baseDir=$($m.artifact)" `
    -d "dependencies=$deps"
    if ($LASTEXITCODE -ne 0) { throw "Failed to fetch $($m.artifact)" }
}
