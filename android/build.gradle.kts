allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// form here 
val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.set(newBuildDir)

subprojects {
     afterEvaluate {
        // this: Project
        if (plugins.hasPlugin("com.android.application") || plugins.hasPlugin("com.android.library")) {
            extensions.configure<com.android.build.gradle.BaseExtension>("android") {
                compileSdkVersion(36)
                buildToolsVersion("36.0.0")
            }
        }

        if (extensions.findByName("android") != null) {
            extensions.configure<com.android.build.gradle.BaseExtension>("android") {
                if (namespace == null) {
                    namespace = group.toString()
                }
            }
        }
    }
    val newSubprojectBuildDir = newBuildDir.dir(name)
    layout.buildDirectory.set(newSubprojectBuildDir)
}
subprojects {
    evaluationDependsOn(":app")
}

// to here 

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
