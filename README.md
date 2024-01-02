# video_chat_app

A Video Chat Flutter Application Built using Jitsi.

Jitsime setup
1. do setup on package readme
2. add these lines:                 // Add below 3 lines for proguard
                                    minifyEnabled true
                                    shrinkResources true
                                    proguardFiles getDefaultProguardFile('proguard-android.txt'), 'proguard-rules.pro'

    inside app/build.gradle: buildtypes, release{// here}
3. add proguard-rules.pro file inside android/app
4. copy its contents from this repo to your project.