FROM java:7-jre
MAINTAINER John Chambers-Malewig

ENV RDECK_USER rundeck
ENV RDECK_BASE ${RDECK_BASE}:=/${RDECK_USER}

RUN adduser --system \
      --home ${RDECK_BASE} \
      ${RDECK_USER}

ENV RDECK_LAUNCHER ${RDECK_BASE}/lib/rundeck-launcher.jar

# From Install Page:
# Installing with Launcher
# Use the launcher as an alternative to a system package:
# 1. Download the launcher jar file.
ADD http://dl.bintray.com/rundeck/rundeck-maven/rundeck-launcher-2.5.3.jar ${RDECK_LAUNCHER}
RUN chown ${RDECK_USER} ${RDECK_LAUNCHER}
USER ${RDECK_USER}

# 2. Define RDECK_BASE environment variable to the location of the install
#     export RDECK_BASE=$HOME/rundeck; # or where you like it
# 3. Create the directory for the installation.
#     mkdir -p $RDECK_BASE 
# 4. Copy the launcher jar to the installation directory.
#     cp rundeck-launcher-2.5.3.jar $RDECK_BASE
# 5. Change directory and run the jar.
#     cd $RDECK_BASE    
#     java -XX:MaxPermSize=256m -Xmx1024m -jar rundeck-launcher-2.5.3.jar
WORKDIR $RDECK_BASE
## ENTRYPOINT ["java"]
## CMD ["-XX:MaxPermSize=256m","-Xmx1024m","-jar","rundeck-launcher-2.5.3.jar"]

ENV _JAVA_OPTIONS "-XX:MaxPermSize=256m -Xmx1024m"

# Install during build, run when appropriate.
RUN java -jar ${RDECK_LAUNCHER} --installonly

EXPOSE 4440 4443

CMD java -jar ${RDECK_LAUNCHER} --skipinstall
