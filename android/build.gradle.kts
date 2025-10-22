// حذف بخش plugins از root build.gradle.kts
// فقط بخش allprojects را نگه دارید

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
