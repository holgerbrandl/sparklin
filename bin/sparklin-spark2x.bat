@echo off
set MAVEN_REPO_BASE=%USERPROFILE%\.m2\repository\org\jetbrains\kotlin
set KOTLIN_VERSION=1.2.61
set KSHELL_REPL_API_VERSION=0.2.5-1.2.60
set SPARKLIN_VERSION=0.2.5

rem Kotlin libraries
set KOTLIN_STDLIB=%MAVEN_REPO_BASE%\kotlin-stdlib\%KOTLIN_VERSION%\kotlin-stdlib-%KOTLIN_VERSION%.jar
set KOTLIN_COMPILER=%MAVEN_REPO_BASE%\kotlin-compiler\%KOTLIN_VERSION%\kotlin-compiler-%KOTLIN_VERSION%.jar
set KOTLIN_SCRIPT_RUNTIME=%MAVEN_REPO_BASE%\kotlin-script-runtime\%KOTLIN_VERSION%\kotlin-script-runtime-%KOTLIN_VERSION%.jar
set KOTLIN_REFLECT=%MAVEN_REPO_BASE%\kotlin-reflect\%KOTLIN_VERSION%\kotlin-reflect-%KOTLIN_VERSION%.jar

rem JLine2 console support
set FUSE_JANSI=%USERPROFILE%\.m2\repository\org\fusesource\jansi\jansi\1.15\jansi-1.15.jar
set KSHELL_REPL_API=%USERPROFILE%\.m2\repository\com\github\khud\kshell-repl-api\%KSHELL_REPL_API_VERSION%\kshell-repl-api-%KSHELL_REPL_API_VERSION%.jar

rem Spark 2.x support
set SPARKLIN_PLUGIN=%USERPROFILE%\.m2\repository\sparklin\sparklin-spark-2.x\%SPARKLIN_VERSION%\sparklin-spark-2.x-%SPARKLIN_VERSION%.jar
set HDFS_BROWSER_PLUGIN=%USERPROFILE%\.m2\repository\sparklin\hdfs-browser\%SPARKLIN_VERSION%\hdfs-browser-%SPARKLIN_VERSION%.jar

rem Please specify path to KShell configuration file, note that:
rem 1) If property config.path isn't specified Sparklin is trying find config file in path %USERPROFILE%\.kshell
rem 2) If file does not exist Spark support would not work because the plugin is disabled by default
set SPARKLIN_CONFIG=C:/Users/vitaly.khudobakhshov/sparklin/conf/spark2x.properties

rem KShell path
set KSHELL=%USERPROFILE%\.m2\repository\sparklin\kshell\%SPARKLIN_VERSION%\kshell-%SPARKLIN_VERSION%.jar

rem Apache Spark home directory must point to Spark version 2.x
set SPARK_HOME=c:\Java\spark-2.3.1-bin-hadoop2.7
set HADOOP_HOME=c:\Java\hadoop-2.8.3

set JARS=%KOTLIN_COMPILER%,%KOTLIN_STDLIB%,%KOTLIN_REFLECT%,%KOTLIN_SCRIPT_RUNTIME%,%KSHELL_REPL_API%,%SPARKLIN_PLUGIN%,%HDFS_BROWSER_PLUGIN%

"%SPARK_HOME%\bin\spark-submit" --jars="%JARS%" --conf "spark.driver.extraJavaOptions=-Dconfig.path=%SPARKLIN_CONFIG%" ^
        --master "local[2]" --class "com.github.khud.sparklin.kshell.KotlinShell" ^
		%KSHELL% ^
		%*