# FieldWise Backend

Multi-module Spring Boot backend built with Gradle (Groovy DSL). This repository contains a root project (`backend`) and multiple subprojects grouped under `apps/` and `modules/`.

---

## Table of contents

* [Project layout](#project-layout)
* [Prerequisites](#prerequisites)
* [Quick start](#quick-start)
* [Gradle command cheat-sheet](#gradle-command-cheat-sheet)

    * [Build & package](#build--package)
    * [Run applications](#run-applications)
    * [Test & quality](#test--quality)
    * [Dependency & insight](#dependency--insight)
    * [Cleaning](#cleaning)
    * [Task discovery](#task-discovery)
* [Module-specific commands](#module-specific-commands)
* [Environment & configuration](#environment--configuration)
* [Database](#database)
* [Running multiple services in parallel](#running-multiple-services-in-parallel)
* [Custom root tasks](#custom-root-tasks)
* [Troubleshooting](#troubleshooting)

---

## Project layout

```
backend/                      # Root Gradle project (settings.gradle, build.gradle)
├─ apps/
│  └─ api/                    # API Gateway / main application (Spring Boot)
└─ modules/
   ├─ audit/                  # Audit service (Boot or library)
   ├─ billing/                # Billing service (Spring Boot)
   ├─ common/                 # Shared library (non-Boot)
   ├─ identity/               # Identity/Auth service (Spring Boot)
   ├─ media/                  # Media service (Spring Boot)
   ├─ ocr/                    # OCR service (Spring Boot)
   ├─ timelogs/               # Timelogs service (Spring Boot)
   └─ workorders/             # Workorders service (Spring Boot)
```

> **Note**: Spring Boot subprojects apply `org.springframework.boot`; pure libraries (like `common`) usually **do not**.

---

## Prerequisites

* **JDK 17** (toolchain is configured)
* **Gradle Wrapper** (use `./gradlew` or `gradlew.bat` — no local Gradle install needed)
* **PostgreSQL** if running modules that depend on it (e.g., `workorders`)

Optional (dev):

* Docker Desktop (if you containerize services)
* IDE with Gradle support (IntelliJ IDEA recommended)

---

## Quick start

```bash
# From repository root (backend/)
# 1) Build everything (runs tests)
./gradlew build

# 2) Run one service (example: workorders)
./gradlew :modules:workorders:bootRun

# 3) Package runnable jars for all Boot apps
./gradlew packageAll
```

---

## Gradle command cheat-sheet

All commands are run from the repository root unless noted.

### Build & package

```bash
# Compile only (no tests)
./gradlew assemble

# Full build (compile + test + package)
./gradlew build

# Build without tests
./gradlew build -x test

# Create Spring Boot fat jar for a specific app
./gradlew :modules:workorders:bootJar
./gradlew :apps:api:bootJar

# Create plain jar for a library module (if applicable)
./gradlew :modules:common:jar

# Build every subproject’s artifact (Boot apps => bootJar, libs => jar)
./gradlew packageAll
```

### Run applications

```bash
# Run one Boot application (hot reload with spring-boot-devtools if present)
./gradlew :modules:workorders:bootRun
./gradlew :apps:api:bootRun

# Run multiple apps using custom aggregated tasks (see [Custom root tasks](#custom-root-tasks))
./gradlew runWorkorders
./gradlew runIdentity
./gradlew runApi

# Run *all* apps (each depends on its bootRun)
./gradlew runAll

# Parallel execution (builds or multiple run tasks start concurrently)
./gradlew --parallel runAll
```

> **Important**: `bootRun` **does not** produce JARs; it only launches the app. Use `bootJar` (or `build`/`packageAll`) to create artifacts under `build/libs`.

### Test & quality

```bash
# Run unit/integration tests for all modules
./gradlew test

# Run tests for a specific module
./gradlew :modules:workorders:test

# Run tests in parallel (depends on your Gradle config)
./gradlew --parallel test

# Run only a specific test class or method
./gradlew :modules:workorders:test --tests "co.wali.workorders.service.WorkOrderServiceTest"
./gradlew :modules:workorders:test --tests "co.wali.workorders.service.WorkOrderServiceTest.someCase"
```

### Dependency & insight

```bash
# Show all available tasks (root or for a module)
./gradlew tasks
./gradlew :modules:workorders:tasks

# Show dependency tree
./gradlew :modules:workorders:dependencies --configuration runtimeClasspath

# Why a dependency is included
./gradlew :modules:workorders:dependencyInsight --dependency postgresql --configuration runtimeClasspath

# Verify Gradle wrapper is at the desired version
./gradlew wrapper --gradle-version 8.10.2
```

### Cleaning

```bash
# Clean build outputs everywhere
./gradlew clean

# Clean a specific module
./gradlew :modules:workorders:clean
```

### Task discovery

```bash
# List tasks of a specific group, or search for tasks containing a keyword
./gradlew tasks --all | grep bootJar
```

---

## Module-specific commands

Below are common commands for each subproject. Omit modules you don’t have.

```bash
# API app
./gradlew :apps:api:bootRun
./gradlew :apps:api:bootJar

# Audit (choose jar or bootJar depending on whether it’s a Boot app or library)
./gradlew :modules:audit:bootRun      # if Boot
./gradlew :modules:audit:bootJar      # if Boot
./gradlew :modules:audit:jar          # if library

# Billing
./gradlew :modules:billing:bootRun
./gradlew :modules:billing:bootJar

# Common (library)
./gradlew :modules:common:jar

# Identity
./gradlew :modules:identity:bootRun
./gradlew :modules:identity:bootJar

# Media
./gradlew :modules:media:bootRun
./gradlew :modules:media:bootJar

# OCR
./gradlew :modules:ocr:bootRun
./gradlew :modules:ocr:bootJar

# Timelogs
./gradlew :modules:timelogs:bootRun
./gradlew :modules:timelogs:bootJar

# Workorders
./gradlew :modules:workorders:bootRun
./gradlew :modules:workorders:bootJar
```

---

## Environment & configuration

This project uses typical Spring profiles (e.g., `dev`, `prod`) and supports environment variables, `.env` files (via `io.github.cdimascio:dotenv-java` if used), and `application-*.yml`.

### Using `.env` (optional)

Create a `.env` file in the module directory you’re running (or project root if centrally loaded):

```
SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/fieldwise
SPRING_DATASOURCE_USERNAME=fieldwise
SPRING_DATASOURCE_PASSWORD=secret
SPRING_JPA_HIBERNATE_DDL_AUTO=update
SPRING_PROFILES_ACTIVE=dev
```

> Ensure your code loads `.env` early in application startup if you rely on it.

### Spring Boot profiles

```bash
# Activate a profile when running
./gradlew :modules:workorders:bootRun --args='--spring.profiles.active=dev'
```

---

## Database

* Default driver: `org.postgresql:postgresql` (42.7.8)
* Configure JDBC in `application.yml` or via env vars as above.
* Run a local PostgreSQL or use Docker:

```bash
docker run --name fieldwise-pg -e POSTGRES_PASSWORD=secret -e POSTGRES_USER=fieldwise -e POSTGRES_DB=fieldwise -p 5432:5432 -d postgres:16
```

---

## Running multiple services in parallel

The root build file provides aggregated tasks to run services. Examples:

```bash
# Start one service via root alias
./gradlew runWorkorders

# Start everything (each service is its own bootRun)
./gradlew --parallel runAll
```

**Reminder**: These `bootRun` tasks are for development. They **do not** create `.jar` files.

---

## Custom root tasks

Your root `build.gradle` defines convenience tasks (examples below). Adjust to match your modules:

```groovy
// Convenience runners
tasks.register("runApi")      { dependsOn(":apps:api:bootRun") }
tasks.register("runAudit")    { dependsOn(":modules:audit:bootRun") }
tasks.register("runBilling")  { dependsOn(":modules:billing:bootRun") }
tasks.register("runCommon")   { dependsOn(":modules:common:bootRun") }
tasks.register("runIdentity") { dependsOn(":modules:identity:bootRun") }
tasks.register("runMedia")    { dependsOn(":modules:media:bootRun") }
tasks.register("runOcr")      { dependsOn(":modules:ocr:bootRun") }
tasks.register("runTimelogs") { dependsOn(":modules:timelogs:bootRun") }
tasks.register("runWorkorders"){ dependsOn(":modules:workorders:bootRun") }

// Start all apps (use --parallel for concurrent startup)
tasks.register("runAll") {
    dependsOn(
        ":apps:api:bootRun",
        ":modules:audit:bootRun",
        ":modules:billing:bootRun",
        ":modules:common:bootRun",
        ":modules:identity:bootRun",
        ":modules:media:bootRun",
        ":modules:ocr:bootRun",
        ":modules:timelogs:bootRun",
        ":modules:workorders:bootRun",
    )
}

// Build artifacts for all modules (Boot apps => bootJar, libs => jar)
tasks.register("packageAll") {
    dependsOn(
        ":apps:api:bootJar",
        ":modules:audit:jar",       // or :modules:audit:bootJar if Boot
        ":modules:billing:bootJar",
        ":modules:common:jar",
        ":modules:identity:bootJar",
        ":modules:media:bootJar",
        ":modules:ocr:bootJar",
        ":modules:timelogs:bootJar",
        ":modules:workorders:bootJar"
    )
}
```
  ```bash
  ./gradlew --parallel packageAll
  ```
---

## Troubleshooting

* **I don’t see any JARs after `runAll`**: `bootRun` doesn’t build JARs. Use `bootJar` or `packageAll`.
* **Port already in use**: Stop existing instance or change `server.port` per module/profile.
* **Dependency version conflicts**: Inspect with `dependencies` and `dependencyInsight` commands above.
* **Gradle daemon issues**: Try `./gradlew --stop` then rerun.
* **Slow build**: Enable parallel + configuration on demand, and cache:

  ```bash
  ./gradlew --parallel --build-cache build
  ```
* **Enable plain jar alongside Boot jar**: In a Boot app build file add:

  ```groovy
  jar { enabled = true }
  ```

---

## License

Proprietary – internal use for FieldWise (update as needed).
