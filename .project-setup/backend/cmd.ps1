mkdir apps,modules
curl.exe https://start.spring.io/starter.zip  -o apps\api.zip -d packaging=jar -d groupId=co.wali -d artifactId=FieldWise -d name=App -d applicationName=App -d packageName=co.wali -d type=gradle-project-kotlin  -d javaVersion=17 -d bootVersion='3.5.7' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\common.zip  -d packaging=jar -d groupId=co.wali -d artifactId=common -d name=Common  -d applicationName=App -d packageName=co.wali -d type=gradle-project-kotlin  -d javaVersion=17 -d bootVersion='3.5.7' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\identity.zip  -d packaging=jar -d groupId=co.wali -d artifactId=identity -d name=Identity -d applicationName=App -d packageName=co.wali -d type=gradle-project-kotlin  -d javaVersion=17 -d bootVersion='3.5.7' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\workorders.zip  -d packaging=jar -d groupId=co.wali -d artifactId=workorders -d name=WorkOrders -d applicationName=App -d packageName=co.wali -d type=gradle-project-kotlin  -d javaVersion=17 -d bootVersion='3.5.7' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\timelogs.zip  -d packaging=jar -d groupId=co.wali -d artifactId=timelogs -d name=TimeLogs -d applicationName=App -d packageName=co.wali -d type=gradle-project-kotlin  -d javaVersion=17 -d bootVersion='3.5.7' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\media.zip  -d packaging=jar -d groupId=co.wali -d artifactId=media -d name=Media -d applicationName=App -d packageName=co.wali -d type=gradle-project-kotlin  -d javaVersion=17 -d bootVersion='3.5.7' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\ocr.zip  -d packaging=jar -d groupId=co.wali -d artifactId=ocr -d name=OCR -d applicationName=App -d packageName=co.wali -d type=gradle-project-kotlin  -d javaVersion=17 -d bootVersion='3.5.7' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\billing.zip  -d packaging=jar -d groupId=co.wali -d artifactId=billing -d name=Billing -d applicationName=App -d packageName=co.wali -d type=gradle-project-kotlin  -d javaVersion=17 -d bootVersion='3.5.7' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
curl.exe https://start.spring.io/starter.zip  -o modules\audit.zip  -d packaging=jar -d groupId=co.wali -d artifactId=audit -d name=Audit -d applicationName=App -d packageName=co.wali -d type=gradle-project-kotlin  -d javaVersion=17 -d bootVersion='3.5.7' -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql


Expand-Archive -Path apps\api.zip -DestinationPath apps\api -Force
Expand-Archive -Path modules\common.zip -DestinationPath modules\common -Force 
Expand-Archive -Path modules\identity.zip -DestinationPath modules\identity -Force
Expand-Archive -Path modules\workorders.zip -DestinationPath modules\workorders -Force
Expand-Archive -Path modules\timelogs.zip -DestinationPath modules\timelogs -Force
Expand-Archive -Path modules\media.zip -DestinationPath modules\media -Force
Expand-Archive -Path modules\ocr.zip -DestinationPath modules\ocr -Force
Expand-Archive -Path modules\billing.zip -DestinationPath modules\billing -Force
Expand-Archive -Path modules\audit.zip -DestinationPath modules\audit -Force

Remove-Item -Path apps\*.zip
Remove-Item -Path modules\*.zip 


# Copy gradle.properties to all modules

Copy-Item -Path ..\.project-setup\backend\module-setup\gradle.properties -Destination .\apps\api\
Copy-Item -Path ..\.project-setup\backend\module-setup\gradle.properties -Destination .\modules\common\
Copy-Item -Path ..\.project-setup\backend\module-setup\gradle.properties -Destination .\modules\identity\
Copy-Item -Path ..\.project-setup\backend\module-setup\gradle.properties -Destination .\modules\workorders\
Copy-Item -Path ..\.project-setup\backend\module-setup\gradle.properties -Destination .\modules\timelogs\
Copy-Item -Path ..\.project-setup\backend\module-setup\gradle.properties -Destination .\modules\media\
Copy-Item -Path ..\.project-setup\backend\module-setup\gradle.properties -Destination .\modules\ocr\
Copy-Item -Path ..\.project-setup\backend\module-setup\gradle.properties -Destination .\modules\billing\
Copy-Item -Path ..\.project-setup\backend\module-setup\gradle.properties -Destination .\modules\audit\



# Copy AppConfig.java to all modules

Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\AppConfig.java -Destination .\apps\api\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\AppConfig.java -Destination .\modules\timelogs\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\AppConfig.java -Destination .\modules\media\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\AppConfig.java -Destination .\modules\ocr\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\AppConfig.java -Destination .\modules\billing\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\AppConfig.java -Destination .\modules\audit\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\AppConfig.java -Destination .\modules\common\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\AppConfig.java -Destination .\modules\identity\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\AppConfig.java -Destination .\modules\workorders\src\main\java\co\wali\

# Copy Welcome.java to all modules
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\Welcome.java -Destination .\apps\api\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\Welcome.java -Destination .\modules\timelogs\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\Welcome.java -Destination .\modules\media\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\Welcome.java -Destination .\modules\ocr\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\Welcome.java -Destination .\modules\billing\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\Welcome.java -Destination .\modules\audit\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\Welcome.java -Destination .\modules\common\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\Welcome.java -Destination .\modules\identity\src\main\java\co\wali\
Copy-Item -Path ..\.project-setup\backend\module-setup\java-example\Welcome.java -Destination .\modules\workorders\src\main\java\co\wali\


# Copy application.properties to all modules
Copy-Item -Path ..\.project-setup\backend\module-setup\application.properties -Destination .\apps\api\src\main\resources
Copy-Item -Path ..\.project-setup\backend\module-setup\application.properties -Destination .\modules\timelogs\src\main\resources
Copy-Item -Path ..\.project-setup\backend\module-setup\application.properties -Destination .\modules\media\src\main\resources
Copy-Item -Path ..\.project-setup\backend\module-setup\application.properties -Destination .\modules\ocr\src\main\resources
Copy-Item -Path ..\.project-setup\backend\module-setup\application.properties -Destination .\modules\billing\src\main\resources
Copy-Item -Path ..\.project-setup\backend\module-setup\application.properties -Destination .\modules\audit\src\main\resources
Copy-Item -Path ..\.project-setup\backend\module-setup\application.properties -Destination .\modules\common\src\main\resources
Copy-Item -Path ..\.project-setup\backend\module-setup\application.properties -Destination .\modules\identity\src\main\resources
Copy-Item -Path ..\.project-setup\backend\module-setup\application.properties -Destination .\modules\workorders\src\main\resources





curl.exe https://start.spring.io/starter.zip  -o apps\test.zip  -d groupId=co.wali -d artifactId=FieldWise -d name=App -d applicationName=App -d packageName=co.wali -d type=gradle-project-kotlin  -d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql
Expand-Archive -Path apps\test.zip -DestinationPath apps\test -Force


curl.exe https://start.spring.io/starter.zip `
-o apps/test.zip `
-d groupId=co.wali `
-d artifactId=FieldWise `
-d name=App `
-d applicationName=App `
-d packageName=co.wali `
-d type=gradle-project-kotlin  `
-d language=java `
-d javaVersion=17 `
-d bootVersion=3.5.7 `
-d packaging=jar `
-d version=0.1.0-SNAPSHOT `
-d description="FieldWise Full Stack Application" `
-d dependencies=batch,data-jpa,data-mongodb,security,web,postgresql



