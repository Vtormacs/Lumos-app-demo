plugins {
    id("com.android.application")
    id("kotlin-android")
    // O plugin do Flutter deve vir depois do Android e Kotlin
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.loumar"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // CORREÇÃO 1: Adicionado o "is" no início (Obrigatório no Kotlin DSL)
        isCoreLibraryDesugaringEnabled = true

        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        // CORREÇÃO 2: Sintaxe simplificada para evitar o erro de Deprecated
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.example.loumar"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        
        // CORREÇÃO 3: Uso do sinal de igual "="
        multiDexEnabled = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // CORREÇÃO 4: Dependência obrigatória para o desugaring funcionar
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}