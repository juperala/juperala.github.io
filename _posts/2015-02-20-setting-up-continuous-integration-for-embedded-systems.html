---
layout: post
title: Continuous integration for embedded systems
date: 2015-02-20 11:29:48.000000000 +02:00
author: juperala
header-img: "img/post-bg-06.jpg"
---

<p>I started a small hobby project to develop a simple web-controllable digital I/O card for controlling and monitoring various kinds of peripheral devices. As a hardware platform I selected Arduino Uno micro-controller board with W5100 Ethernet Shield for network access. Arduino was selected as hardware platform due its simplicity and low price point (Arduino Uno compatible board + Ethernet shield cost under $15 with home delivery). To follow-up agile and TDD development practices I decided to setup a continuous integration environment for automated building and testing of the control software in the embedded hardware.</p>
<p><a href="http://jperala.fi/wp-content/uploads/2015/02/rounded_corners.jpg"><img class=" size-medium wp-image-66 aligncenter" src="{{ site.baseurl }}/assets/rounded_corners-300x155.jpg" alt="rounded_corners" width="300" height="155" /></a>In general setting up of the continuous integration for embedded system projects is quite similar as for any other project, but you need to take into consideration some additional issues such:</p>
<ul>
<li>Uploading and flashing the build software binary into the embedded hardware.</li>
<li>Wiring and triggering (or simulating) of physical interfaces of embedded hardware.</li>
<li>Gathering of logs and debug traces from the embedded system.</li>
</ul>
<p>This example shows how to setup Arduino-based embedded system project to run on Jenkins continuous integration server. In this example the Jenkins CI is running in Ubuntu server and tests are implemented in Java (JUnit + Selenium) with Maven project configuration.</p>
<p><!--more--></p>
<hr />
<h1>System Overview</h1>
<p>The example project is simple web-controllable digital I/O board with 4 inputs and 4 outputs. The state of I/O ports can be monitored and controlled via HTTP web-application shown below.</p>
<p><a href="http://jperala.fi/wp-content/uploads/2015/02/pic.png"><img class=" size-medium wp-image-54 alignnone" src="{{ site.baseurl }}/assets/pic-300x181.png" alt="pic" width="300" height="181" /></a></p>
<p>For the test setup the input pins 1-4 are connected to the corresponding output pins 1-4 enabling testing of both (1) reading input values and (2) writing output values. The system produces system log for test purposes via serial communication port. The test setup is illustrated in Figure below.</p>
<h1><a href="http://jperala.fi/wp-content/uploads/2015/02/arduino_jenkins.png"><img class=" size-medium wp-image-34 alignnone" src="{{ site.baseurl }}/assets/arduino_jenkins-300x145.png" alt="arduino_jenkins" width="300" height="145" /></a></h1>
<h1>Prerequisites</h1>
<p>First we need to setup the test and development environments. The tools used in this example are:</p>
<ul>
<li>Arduino IDE, development environment for Arduino development.</li>
<li>Ino, command line tools for Arduino to integrate it with Jenkins CI *</li>
<li>Picocom, terminal emulation for serial communication (used by Ino).</li>
<li>Jenkins CI, continuous integration environment.</li>
</ul>
<p>*) Since Arduino version 1.5.0 there is also native command-line support in Arduino, which can be also used for Jenkins CI integration. More information about Arduino CLI options can be found <a href="http://playground.arduino.cc/Learning/CommandLine">here</a>.</p>
<p><strong>Install Arduino IDE and tools</strong></p>
<pre class="lang:sh decode:true ">sudo apt-get install arduino arduino-core</pre>
<p>See details for additional configuration in <a href="http://playground.arduino.cc/Linux/Ubuntu">Arduino Playground</a>.</p>
<p><strong>Install Ino command line toolkit for Arduino</strong></p>
<pre class="lang:sh decode:true ">sudo pip install ino</pre>
<p>See details for additional configuration in <a href="http://inotool.org">Ino website</a>.</p>
<p><strong>Install Picocom terminal emulation for serial communication</strong></p>
<pre class="lang:sh decode:true ">sudo apt-get install picocom</pre>
<p><strong>Install Jenkins CI </strong></p>
<pre class="lang:sh decode:true ">wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ &gt; /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
</pre>
<p>See details for additional configuration in <a href="https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu">Jenkins CI wiki</a>.</p>
<h1>Create Arduino/Ino code project</h1>
<p>After installation of the toolkit, we create the Arduino project using Ino tools</p>
<pre class="lang:sh decode:true ">mkdir webio
cd webio
ino init</pre>
<p>The <em>ino init</em> command creates project structure with <em>src</em> and <em>lib</em> folders and a <em>src/sketch.ino</em> file as a base sketch to implement the application code.</p>
<pre class="lang:sh decode:true ">+---lib
+---src
    |   sketch.ino
</pre>
<h1>Create maven test project</h1>
<p>Next we create a simple Maven project for tests. First we add maven <em>pom.xml</em> to configure the JUnit tests using maven-surefire-plugin.</p>
<pre class="lang:default decode:true ">&lt;project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd"&gt;
    &lt;modelVersion&gt;4.0.0&lt;/modelVersion&gt;
    &lt;groupId&gt;fi.jperala.webio&lt;/groupId&gt;
    &lt;artifactId&gt;webio-tests&lt;/artifactId&gt;
    &lt;version&gt;1.0-SNAPSHOT&lt;/version&gt;
    &lt;packaging&gt;jar&lt;/packaging&gt;
    &lt;dependencyManagement&gt;
        &lt;dependencies&gt;
            &lt;dependency&gt;
                &lt;groupId&gt;junit&lt;/groupId&gt;
                &lt;artifactId&gt;junit&lt;/artifactId&gt;
                &lt;version&gt;4.11&lt;/version&gt;
            &lt;/dependency&gt;
            &lt;dependency&gt;
                &lt;groupId&gt;org.seleniumhq.selenium&lt;/groupId&gt;
                &lt;artifactId&gt;selenium-java&lt;/artifactId&gt;
                &lt;version&gt;2.44.0&lt;/version&gt;
            &lt;/dependency&gt;  
            &lt;dependency&gt;
                &lt;groupId&gt;com.google.code.gson&lt;/groupId&gt;
                &lt;artifactId&gt;gson&lt;/artifactId&gt;
                &lt;version&gt;2.2.4&lt;/version&gt;
            &lt;/dependency&gt;
            &lt;dependency&gt;
                &lt;groupId&gt;com.github.detro&lt;/groupId&gt;
                &lt;artifactId&gt;phantomjsdriver&lt;/artifactId&gt;
                &lt;version&gt;1.2.0&lt;/version&gt;
            &lt;/dependency&gt;         
        &lt;/dependencies&gt;
    &lt;/dependencyManagement&gt;
    &lt;dependencies&gt;
        &lt;dependency&gt;
            &lt;groupId&gt;junit&lt;/groupId&gt;
            &lt;artifactId&gt;junit&lt;/artifactId&gt;
        &lt;/dependency&gt;
        &lt;dependency&gt;
            &lt;groupId&gt;org.seleniumhq.selenium&lt;/groupId&gt;
            &lt;artifactId&gt;selenium-java&lt;/artifactId&gt;
        &lt;/dependency&gt;  
        &lt;dependency&gt;
            &lt;groupId&gt;com.github.detro&lt;/groupId&gt;
            &lt;artifactId&gt;phantomjsdriver&lt;/artifactId&gt;
        &lt;/dependency&gt;         
    &lt;/dependencies&gt;
    &lt;build&gt;
        &lt;pluginManagement&gt;
            &lt;plugins&gt;
                &lt;plugin&gt;
                    &lt;groupId&gt;org.apache.maven.plugins&lt;/groupId&gt;
                    &lt;artifactId&gt;maven-surefire-plugin&lt;/artifactId&gt;
                    &lt;version&gt;2.18.1&lt;/version&gt;
                &lt;/plugin&gt;
                &lt;plugin&gt;
                    &lt;groupId&gt;org.apache.maven.plugins&lt;/groupId&gt;
                    &lt;artifactId&gt;maven-compiler-plugin&lt;/artifactId&gt;
                    &lt;version&gt;3.2&lt;/version&gt;
                    &lt;configuration&gt;
                        &lt;source&gt;1.6&lt;/source&gt;
                        &lt;target&gt;1.6&lt;/target&gt;
                    &lt;/configuration&gt;
                &lt;/plugin&gt;
            &lt;/plugins&gt;            
        &lt;/pluginManagement&gt;
        &lt;plugins&gt;
            &lt;plugin&gt;
                &lt;groupId&gt;org.apache.maven.plugins&lt;/groupId&gt;
                &lt;artifactId&gt;maven-surefire-plugin&lt;/artifactId&gt;
            &lt;/plugin&gt;
            &lt;plugin&gt;
                &lt;groupId&gt;org.apache.maven.plugins&lt;/groupId&gt;
                &lt;artifactId&gt;maven-compiler-plugin&lt;/artifactId&gt;
            &lt;/plugin&gt;
        &lt;/plugins&gt;
    &lt;/build&gt;
&lt;/project&gt;</pre>
<p>In the <em>pom.xml</em> we define dependencies for selenium-java for web application testing with Selenium. In addition, we define dependency for phantomjsdriver to use the PhantomJS and GhostDriver to execute our Selenium tests in headless PhantomJS browser.</p>
<p>Next we add the JUnit test (<em>WebIOTest.java</em> in folder <em>src/main/test/fi/jperala/webio</em> to test changing the output pin state and verifying that the both input and output pin states were changed correctly. The test is parameterized and it takes as input the pin index under test.<br />
<!-- HTML generated using hilite.me --></p>
<pre class="lang:java decode:true ">package fi.jperala.webio;

import java.util.concurrent.TimeUnit;
import org.junit.*;
import org.openqa.selenium.*;
import java.util.Arrays;
import java.util.Collection;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;
import org.openqa.selenium.phantomjs.PhantomJSDriver;
import org.openqa.selenium.phantomjs.PhantomJSDriverService;
import org.openqa.selenium.remote.DesiredCapabilities;

@RunWith(Parameterized.class)
public class WebIOTest {

    /**
     * Tests are parameterized by I/O number.
     *
     * @return Test parameters
     */
    @Parameterized.Parameters
    public static Collection inputPins() {
        return Arrays.asList(new Object[][]{
            {0}, {1}, {2}, {3}
        });
    }

    private static final String PHANTOMJS_BINARY = "/usr/bin/phantomjs";
    private static final String BASE_URL = "http://192.168.0.111/";
    private final int pinNo;
    private WebDriver driver;

    public WebIOTest(int pinNo) {
        this.pinNo = pinNo;
    }

    @Before
    public void setUp() throws Exception {
        DesiredCapabilities caps = new DesiredCapabilities();
        caps.setCapability(PhantomJSDriverService.PHANTOMJS_EXECUTABLE_PATH_PROPERTY, PHANTOMJS_BINARY);
        driver = new PhantomJSDriver(caps);
        driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
    }

    @After
    public void tearDown() throws Exception {
        driver.quit();
    }

    /**
     * Test that input and output are always in same state and changing the out
     * state changes both the input and output states correctly.
     *
     * Board test configuration: * Inputs are connected to outputs
     *
     * @throws Exception Test error
     */
    @Test
    public void testInputStateChange() throws Exception {
        driver.get(BASE_URL);
        boolean beforeOutputState = getPinState(pinNo, false);
        boolean beforeInputState = getPinState(pinNo, true);
        Assert.assertEquals("Input and output not in same state.", beforeOutputState, beforeInputState);
        changeInputState(pinNo);
        Assert.assertNotEquals("Output state was not changed.", beforeOutputState, getPinState(pinNo, false));
        Assert.assertNotEquals("Input state was not changed.", beforeOutputState, getPinState(pinNo, true));
    }

    /**
     * Change the input state by clicking the button in web application.
     *
     * @param index Input index
     */
    private void changeInputState(int index) {
        driver.findElement(By.xpath("(//button[@name='pin'])[" + (index + 1) + "]")).click();
    }

    /**
     * Get the pin state by finding the value in the web application.
     *
     * @param index Input index
     * @param input True to get Input pin, false to get Output pin.
     * @return True if pin is HIGH, false if LOW.
     */
    private boolean getPinState(int index, boolean input) {
        final String pattern;
        if (input) {
            pattern = ".*Input #" + index + ": (\d).*";
        } else {
            pattern = ".*Output #" + index + ": (\d).*";
        }
        final String bodyText = driver.findElement(By.cssSelector("body")).getText();

        Pattern r = Pattern.compile(pattern);
        Matcher m = r.matcher(bodyText);
        if (m.find()) {
            String value = m.group(1);
            if (value.equalsIgnoreCase("0")) {
                return false;
            } else if (value.equalsIgnoreCase("1")) {
                return true;
            } else {
                throw new RuntimeException("Failed to parse input state, state = " + value);
            }
        } else {
            throw new RuntimeException("Failed to parse input state, no pattern match.");
        }
    }
}</pre>
<p>In the end, we have a project folder with ino and maven project that is now ready to be committed in to version control system of your choice and to be configured for Jenkins continous integration. The resulted project folder structure is following:</p>
<pre class="lang:default decode:true ">|   pom.xml
+---lib
+---src
|   |   sketch.ino
|   \---test
|       \---java
|           \---fi
|               \---jperala
|                   \---webio
|                       |   WebIOTest.java</pre>
<p>In this example BitBucket was used as Git version control repository. You may want to add a <em>.gitignore</em> (or svn:ignore in case of Subversion) file to avoid any build artifacts (i.e. <em>target</em> and <em>lib/.holder</em> folders) to be committed in the repository.</p>
<h1>Setup Jenkins project</h1>
<p><strong>Create new project</strong></p>
<p>First, we create a new free-style Jenkins project:</p>
<p><a href="http://jperala.fi/wp-content/uploads/2015/02/jenkins_new_project2.png"><img class="alignnone size-medium wp-image-63" src="{{ site.baseurl }}/assets/jenkins_new_project2-300x93.png" alt="jenkins_new_project" width="300" height="93" /></a></p>
<p><strong>Configure project</strong></p>
<p>Next, we configure the created project:</p>
<p><a href="http://jperala.fi/wp-content/uploads/2015/02/jenkins_project_configure_1.png"><img class="alignnone size-medium wp-image-49" src="{{ site.baseurl }}/assets/jenkins_project_configure_1-300x158.png" alt="jenkins_project_configure_1" width="300" height="158" /></a></p>
<ul>
<li>Project name and description. Name and description of the project.</li>
<li>Handling of old builds. We keep max. 10 builds from last 7 days.</li>
<li>Source Code Management. We configure Jenkins to get the code from BitBucket.</li>
</ul>
<p><a href="http://jperala.fi/wp-content/uploads/2015/02/jenkins_project_configure_2.png"><img class="alignnone size-medium wp-image-50" src="{{ site.baseurl }}/assets/jenkins_project_configure_2-300x155.png" alt="jenkins_project_configure_2" width="300" height="155" /></a></p>
<ul>
<li>Build. We configure the Jenkins to carry out the build and test steps:
<ul>
<li><em>Ino Build</em>. Build the Arduino project.</li>
<li><em>Ino Upload</em>. Upload the build binary to Arduino hardware.</li>
<li><em>Maven clean test</em>. Execute maven tests against the embedded system.</li>
</ul>
</li>
<li>Post-build. We configure the Jenkins to publish the JUnit test results.</li>
</ul>
<p><strong>Execute project</strong></p>
<p>Finally, we are ready execute the Jenkins project. Once launched, the Jenkins fetches the project from version control, builds and uploads the binary to embedded system, and executes the JUnit/Selenium tests. The build process can be monitored from the Jenkins Console Outptut.</p>
<p><a href="http://jperala.fi/wp-content/uploads/2015/02/jenkins_console.png"><img class="alignnone size-medium wp-image-51" src="{{ site.baseurl }}/assets/jenkins_console-300x155.png" alt="jenkins_console" width="300" height="155" /></a></p>
<p>Enjoy!</p>
