// settings.gradle.kts — root project (backend)

rootProject.name = "fieldwise-backend"

// Logical project grouping
include(
    "apps:api",
    "modules:common",
    "modules:identity",
    "modules:workorders",
    "modules:timelogs",
    "modules:media",
    "modules:ocr",
    "modules:billing",
    "modules:audit",
)

// Optional: set consistent project directory layout (explicitly resolve subproject paths)
rootProject.children.forEach { group ->
    group.children.forEach { module ->
        module.projectDir = file("${group.name}/${module.name}")
    }
}

// Optional (recommended):
// Enable Gradle build caching and feature previews
enableFeaturePreview("TYPESAFE_PROJECT_ACCESSORS") // gives `projects.apps.api` style references
enableFeaturePreview("STABLE_CONFIGURATION_CACHE") // faster re-runs

// Optional: Configure plugin management (useful for consistent plugin versions)
pluginManagement {
    repositories {
        gradlePluginPortal()
        mavenCentral()
    }
}
