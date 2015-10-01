FROM java:7-jre
MAINTAINER John Chambers-Malewig

# From Install Page:
# Installing with Launcher
# Use the launcher as an alternative to a system package:
# 1. Download the launcher jar file.
ADD http://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-2.5.3.jar /tmp/rundeck-launcher-2.5.3.jar

# 2. Define RDECK_BASE environment variable to the location of the install
#     export RDECK_BASE=$HOME/rundeck; # or where you like it
ENV RDECK_BASE /rundeck

# 3. Create the directory for the installation.
#     mkdir -p $RDECK_BASE 
RUN mkdir -p $RDECK_BASE

# 4. Copy the launcher jar to the installation directory.
#     cp rundeck-launcher-2.5.3.jar $RDECK_BASE
RUN cp /tmp/rundeck-launcher-2.5.3.jar $RDECK_BASE

# 5. Change directory and run the jar.
#     cd $RDECK_BASE    
#     java -XX:MaxPermSize=256m -Xmx1024m -jar rundeck-launcher-2.5.3.jar
WORKDIR $RDECK_BASE

EXPOSE 4440 4443

ENTRYPOINT ["java"]

CMD ["-XX:MaxPermSize=256m" "-Xmx1024m" "-jar" "rundeck-launcher-2.5.3.jar"]
