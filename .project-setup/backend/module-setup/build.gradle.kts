// build.gradle.kts — root (parent) project

plugins {
    // Keep the plugins available to child modules but don't auto-apply Boot to the root
    java
    id("org.springframework.boot") version "3.5.7" apply false
    id("io.spring.dependency-management") version "1.1.7" apply false
}

group = "co.wali"
version = "0.0.1-SNAPSHOT"
description = "FieldWise Backend"

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(21))
    }
}

repositories {
    mavenCentral()
}

subprojects {
    // Apply base plugins to all modules
    apply(plugin = "java")
    apply(plugin = "io.spring.dependency-management")

    group = rootProject.group
    version = rootProject.version

    repositories {
        mavenCentral()
    }

    // Ensure Java 21 everywhere
    extensions.configure<JavaPluginExtension> {
        toolchain {
            languageVersion.set(JavaLanguageVersion.of(17))
        }
    }

    tasks.withType<Test>().configureEach {
        useJUnitPlatform()
    }
}

/**
 * Module layout
 * - Boot apps: produce bootJar & have bootRun
 * - Libraries: produce plain jar
 */
val bootAppModules = mapOf(
    "Api"        to ":apps:api",
    "Billing"    to ":modules:billing",
    "Identity"   to ":modules:identity",
    "Media"      to ":modules:media",
    "Ocr"        to ":modules:ocr",
    "Timelogs"   to ":modules:timelogs",
    "Workorders" to ":modules:workorders",
)

// Treat these as plain libraries (no bootRun)
val libraryModules = listOf(
    ":modules:audit",
    ":modules:common",
)

// --- Convenience runners (use --parallel to run them simultaneously) ---
bootAppModules.forEach { (prettyName, path) ->
    tasks.register("run$prettyName") {
        dependsOn("$path:bootRun")
    }
}

tasks.register("runAll") {
    dependsOn(bootAppModules.values.map { "$it:bootRun" })
    // Tip: gradlew runAll --parallel
}

// --- Packaging helpers ---
tasks.register("packageAll") {
    dependsOn(
        bootAppModules.values.map { "$it:bootJar" } +
        libraryModules.map { "$it:jar" }
    )
    // Tip: gradlew packageAll --parallel
}
