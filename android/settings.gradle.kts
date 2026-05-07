//pluginManagement {
//    val flutterSdkPath =
//        run {
//            val properties = java.util.Properties()
//            file("local.properties").inputStream().use { properties.load(it) }
//            val flutterSdkPath = properties.getProperty("flutter.sdk")
//            require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
//            flutterSdkPath
//        }
//
//    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")
//
//    repositories {
//        google()
//        mavenCentral()
//        gradlePluginPortal()
//    }
//}
//
//plugins {
//    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
//    id("com.android.application") version "8.11.1" apply false
//    id("org.jetbrains.kotlin.android") version "2.2.20" apply false
//}
//
//include(":app")

// ###################################

//pluginManagement {
//    val props = java.util.Properties()
//    file("local.properties").inputStream().use { props.load(it) }
//
//    val flutterSdkPath = props.getProperty("flutter.sdk")
//        ?: error("flutter.sdk not set in local.properties")
//
//    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")
//
//    repositories {
//        google()
//        mavenCentral()
//        gradlePluginPortal()
//    }
//}
//
//plugins {
//    id("dev.flutter.flutter-plugin-loader") version "1.0.0"
//
//    // ✅ Gradle 8.14 compatible pick (safe)
//    id("com.android.application") version "8.13.0" apply false
//    id("org.jetbrains.kotlin.android") version "2.1.0" apply false
//
//    // ✅ Firebase google-services plugin
//    id("com.google.gms.google-services") version "4.4.4" apply false
//}
//
//include(":app")



import org.gradle.api.Project

pluginManagement {
    val props = java.util.Properties()
    file("local.properties").inputStream().use { props.load(it) }

    val flutterSdkPath = props.getProperty("flutter.sdk")
        ?: error("flutter.sdk not set in local.properties")

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0"

    // ✅ Gradle 8.14 compatible pick (safe)
    id("com.android.application") version "8.13.0" apply false
    id("org.jetbrains.kotlin.android") version "2.1.0" apply false

    // ✅ Firebase google-services plugin
    id("com.google.gms.google-services") version "4.4.4" apply false
}

include(":app")

// ============================================================
// ✅ FIX: Force compileSdk 36 for all Android submodules/plugins
// (e.g. flutter_displaymode compiled against 33 causes AAR error)
// ============================================================

fun Project.forceCompileSdk(api: Int) {
    extensions.findByName("android")?.let { androidExt ->
        // Different AGP versions use different setter names
        val setters = listOf("setCompileSdk", "setCompileSdkVersion")
        for (name in setters) {
            try {
                val m = androidExt.javaClass.getMethod(name, Int::class.javaPrimitiveType)
                m.invoke(androidExt, api)
                return
            } catch (_: Throwable) {
                // ignore and try next setter
            }
        }
    }
}

gradle.beforeProject {
    plugins.withId("com.android.application") { forceCompileSdk(36) }
    plugins.withId("com.android.library") { forceCompileSdk(36) }
}

