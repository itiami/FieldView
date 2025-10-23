curl.exe https://start.spring.io/starter.zip  -o apps\api.zip -d packaging=jar -d groupId=co.wali -d artifactId=FieldWise -d name=App -d applicationName=App -d packageName=co.wali -d type=gradle-project -d javaVersion=17 -d bootVersion='4.0.0-M3' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\common.zip  -d packaging=jar -d groupId=co.wali -d artifactId=common -d packageName=co.wali.common -d type=gradle-project -d javaVersion=17 -d bootVersion='4.0.0-M3' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\identity.zip  -d packaging=jar -d groupId=co.wali -d artifactId=identity -d name=App -d applicationName=App -d packageName=co.wali.identity -d type=gradle-project -d javaVersion=17 -d bootVersion='4.0.0-M3' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\workorders.zip  -d packaging=jar -d groupId=co.wali -d artifactId=workorders -d name=App -d applicationName=App -d packageName=co.wali.workorders -d type=gradle-project -d javaVersion=17 -d bootVersion='4.0.0-M3' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\timelogs.zip  -d packaging=jar -d groupId=co.wali -d artifactId=timelogs -d name=App -d applicationName=App -d packageName=co.wali.timelogs -d type=gradle-project -d javaVersion=17 -d bootVersion='4.0.0-M3' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\media.zip  -d packaging=jar -d groupId=co.wali -d artifactId=media -d name=App -d applicationName=App -d packageName=co.wali.media -d type=gradle-project -d javaVersion=17 -d bootVersion='4.0.0-M3' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\ocr.zip  -d packaging=jar -d groupId=co.wali -d artifactId=ocr -d name=App -d applicationName=App -d packageName=co.wali.ocr -d type=gradle-project -d javaVersion=17 -d bootVersion='4.0.0-M3' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\billing.zip  -d packaging=jar -d groupId=co.wali -d artifactId=billing -d name=App -d applicationName=App -d packageName=co.wali.billing -d type=gradle-project -d javaVersion=17 -d bootVersion='4.0.0-M3' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\audit.zip  -d packaging=jar -d groupId=co.wali -d artifactId=audit -d name=App -d applicationName=App -d packageName=co.wali.audit -d type=gradle-project -d javaVersion=17 -d bootVersion='4.0.0-M3' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql


curl.exe https://start.spring.io/starter.zip  -o apps\test.zip -d packaging=jar -d groupId=co.wali -d artifactId=FieldWise -d name=App -d applicationName=App -d packageName=co.wali -d type=gradle-project -d javaVersion=17 -d bootVersion='4.0.0-M3' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql

Expand-Archive -Path apps\api.zip -DestinationPath apps\api -Force
Expand-Archive -Path modules\common.zip -DestinationPath modules\common -Force 
Expand-Archive -Path modules\identity.zip -DestinationPath modules\identity -Force
Expand-Archive -Path modules\workorders.zip -DestinationPath modules\workorders -Force
Expand-Archive -Path modules\timelogs.zip -DestinationPath modules\timelogs -Force
Expand-Archive -Path modules\media.zip -DestinationPath modules\media -Force
Expand-Archive -Path modules\ocr.zip -DestinationPath modules\ocr -Force
Expand-Archive -Path modules\billing.zip -DestinationPath modules\billing -Force
Expand-Archive -Path modules\audit.zip -DestinationPath modules\audit -Force


Copy-Item .\.project-setup\module-setup\java-example\*.java -Destination .\apps\api\src\main\java\co\wali\, .\modules\common\src\main\java\co\wali\common\, .\modules\identity\src\main\java\co\wali\identity\, .\modules\workorders\src\main\java\co\wali\workorders\ .. etc..
Copy-Item .\.project-setup\module-setup\application.properties -Destination .\apps\api\src\main\java\co\wali\, .\modules\common\src\main\java\co\wali\common\, .\modules\identity\src\main\java\co\wali\identity\, .\modules\workorders\src\main\java\co\wali\workorders\ .. etc..
Copy-Item .\.project-setup\module-setup\build.gradle -Destination .\apps\api\, .\modules\common\, .\modules\identity\, .\modules\workorders\ .. etc..
Copy-Item .\.project-setup\module-setup\gradle.properties -Destination .\apps\api\, .\modules\common\, .\modules\identity\, .\modules\workorders\ .. etc..
Copy-Item .\.project-setup\module-setup\settings.gradle -Destination .\apps\api\, .\modules\common\, .\modules\identity\, .\modules\workorders\ .. etc..



curl.exe https://start.spring.io/starter.zip  -o apps\test.zip  -d groupId=co.wali -d artifactId=FieldWise -d name=App -d applicationName=App -d packageName=co.wali -d type=gradle-project -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
Expand-Archive -Path apps\test.zip -DestinationPath apps\test -Force


curl.exe https://start.spring.io/starter.zip `
-o apps/test.zip `
-d groupId=co.wali `
-d artifactId=FieldWise `
-d name=App `
-d applicationName=App `
-d packageName=co.wali `
-d type=gradle-project `
-d language=java `
-d javaVersion=17 `
-d bootVersion=4.0.0 (M3) `
-d packaging=jar `
-d version=0.1.0-SNAPSHOT `
-d description="FieldWise Full Stack Application" `
-d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql


