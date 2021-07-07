
# Sample Dockerfile
# Indicates that the windowsservercore image will be used as the base image.
#FROM openjdk:8-jdk-windowsservercore-1809
FROM openjdk:windowsservercore-1803


WORKDIR /chromeapp

#chromedriver environment path
ENV WEBDRIVERS="C:\webdrivers"

#download standalone file from seleniumhq https://www.seleniumhq.org/download/ 4
#VOLUME C:/Users/e673878/Documents/Docker/image-chrome

COPY selenium-server-standalone-3.141.59.jar C:/server/
COPY selenium-server-4.0.0-beta-4.jar C:/server/
COPY chromedriver.exe C:/server/
COPY chromedriver.exe C:/webdrivers/
COPY ChromeStandaloneSetup64.exe ./
COPY ChromeStandaloneSetup.exe ./


#add to PATH
SHELL ["cmd", "/S", "/C"]
RUN setx /M PATH "%PATH%;%WEBDRIVERS%"

#go back to powershell commands after running command prompt commands
SHELL ["Powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

#install chrome
RUN .\ChromeStandaloneSetup.exe /silent /install

#run command prompt commands for checking google default installation
SHELL ["cmd", "/S", "/C"]
RUN wmic product get name,version


RUN wmic datafile where name="C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe" get Version /value

#ENTRYPOINT ["java"]

#FROM mcr.microsoft.com/dotnet/framework/runtime:4.8-windowsservercore-ltsc2019
#RUN mkdir installers 
#COPY ChromeStandaloneSetup64.exe ./
#RUN .\ChromeStandaloneSetup64.exe /silent /install

#RUN wmic datafile where name="C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe" get Version /value

#CMD "CMD"