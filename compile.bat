@echo off
javac -cp "C:\xampp\tomcat\lib\servlet-api.jar;C:\Program Files\Apache Software Foundation\Tomcat 10.1\lib\servlet-api.jar;web\WEB-INF\lib\*" -d build\web\WEB-INF\classes src\java\ovr\*.java
echo Build Complete
