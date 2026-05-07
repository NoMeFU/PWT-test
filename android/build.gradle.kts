//allprojects {
//    repositories {
//        google()
//        mavenCentral()
//    }
//}
//val newBuildDir: Directory =
//    rootProject.layout.buildDirectory
//        .dir("../../build")
//        .get()
//rootProject.layout.buildDirectory.value(newBuildDir)
//subprojects {
//    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
//    project.layout.buildDirectory.value(newSubprojectBuildDir)
//}
//subprojects {
//    project.evaluationDependsOn(":app")
//}
//tasks.register<Delete>("clean") {
//    delete(rootProject.layout.buildDirectory)
//}

import org.gradle.api.file.Directory
import org.gradle.api.tasks.Delete

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

/**
 * Flutter default shared build directory setup
 */
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()

rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

/**
 * ✅ FIX: Force compileSdk for plugin modules (no afterEvaluate)
 * This fixes: :flutter_displaymode compiled against 33 but deps require 34+
 */
subprojects {

    fun forceCompileSdk36() {
        extensions.findByName("android")?.let { androidExt ->
            try {
                val method = androidExt.javaClass.getMethod(
                    "setCompileSdkVersion",
                    Int::class.javaPrimitiveType
                )
                method.invoke(androidExt, 36)
            } catch (_: Throwable) {
                // ignore safely
            }
        }
    }

    // When Android plugins are applied, set compileSdk immediately
    plugins.withId("com.android.application") { forceCompileSdk36() }
    plugins.withId("com.android.library") { forceCompileSdk36() }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
