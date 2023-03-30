/*
 * This file was generated by the Gradle 'init' task.
 *
 * The settings file is used to specify which projects to include in your build.
 *
 * Detailed information about configuring a multi-project build in Gradle can be found
 * in the user manual at https://docs.gradle.org/7.4.2/userguide/multi_project_builds.html
 */


dependencyResolutionManagement {
    repositories {
        maven {
            url = uri("https://oss.sonatype.org/content/repositories/snapshots/")
        }
        mavenCentral()
        mavenLocal()
    }
    versionCatalogs {
        create("libs") {
            from("org.eclipse.edc:edc-versions:0.0.1-SNAPSHOT")
            // this is not part of the published EDC Version Catalog, so we'll just "amend" it
            library("dnsOverHttps", "com.squareup.okhttp3", "okhttp-dnsoverhttps").versionRef("okhttp")
        }
    }
}

include(":edc-ionos-extension:data-plane-ionos-s3")

include(":edc-ionos-extension:provision-ionos-s3")

include(":edc-ionos-extension:ionos-s3-core")

include(":connector")
include(":example:file-transfer-push:provider")
include(":example:file-transfer-push:consumer")
include(":example:file-transfer-push:transfer-file")
include(":example:file-transfer-pull:http-pull-connector")
include(":example:file-transfer-pull:http-pull-consumer")
include(":example:file-transfer-pull:http-pull-provider")
include(":example:file-transfer-pull:backend-service")
include(":example:file-transfer-multicloud:provider")
include(":example:file-transfer-multicloud:consumer")
