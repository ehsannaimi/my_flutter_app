plugins {
    id("com.android.application") // بدون version
    kotlin("android")             // بدون version
}

android {
    compileSdk = 34
    defaultConfig {
        applicationId = "com.example.my_flutter_app"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }
    buildTypes {
        release {
            isMinifyEnabled = false
        }
    }
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.10")
}
