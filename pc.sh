mvn clean package -Dmaven.test.skip=true

rm -f /E/jetty/webapps/mvcdemo.war

cp ./target/mvcdemo.war /E/jetty/webapps