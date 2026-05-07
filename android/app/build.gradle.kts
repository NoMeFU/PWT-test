import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")

    // Firebase (Google Services)
    id("com.google.gms.google-services")

    // Flutter plugin (must be last)
    id("dev.flutter.flutter-gradle-plugin")
}

/* -------------------- local.properties -------------------- */
val localProperties = Properties()
val localPropertiesFile = rootProject.file("local.properties")
if (localPropertiesFile.exists()) {
    localPropertiesFile.inputStream().use(localProperties::load)
}

val flutterVersionCode = localProperties.getProperty("flutter.versionCode")?.toIntOrNull() ?: 1
val flutterVersionName = localProperties.getProperty("flutter.versionName") ?: "1.0"

/* -------------------- key.properties (optional) -------------------- */
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.lawbug.wagetimekeeper"

    // ✅ Updated to compile against SDK 36
    compileSdk = 36

    // Keep Flutter NDK version
    ndkVersion = flutter.ndkVersion

    defaultConfig {
        applicationId = "com.lawbug.wagetimekeeper"

        // ✅ Explicitly set minSdk (Flutter default is 21)
        minSdk = flutter.minSdkVersion

        // ✅ Target SDK 34 (safe for now)
        targetSdk = 35

        versionCode = flutterVersionCode
        versionName = flutterVersionName
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    /* -------------------- Signing Config -------------------- */
    signingConfigs {
        // Only create release signing if key.properties exists
        if (keystorePropertiesFile.exists()) {
            create("release") {
                keyAlias = keystoreProperties["keyAlias"] as String?
                keyPassword = keystoreProperties["keyPassword"] as String?
                storeFile = (keystoreProperties["storeFile"] as String?)?.let { file(it) }
                storePassword = keystoreProperties["storePassword"] as String?
            }
        }
    }

    buildTypes {
        debug {
            // debug defaults ok
        }
        release {
            // If signing config exists, use it, otherwise fallback to debug signing
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }

            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

flutter {
    source = "../.."
}
