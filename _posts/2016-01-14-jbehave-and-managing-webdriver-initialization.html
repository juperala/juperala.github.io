---
layout: post
title: JBehave and managing WebDriver initialization
date: 2016-01-14 22:44:26.000000000 +02:00
author: juperala
header-img: "img/post-bg-06.jpg"
---
<p><a href="http://jbehave.org/" target="_blank">JBehave</a> is a BDD framework similar to <a href="https://cucumber.io/" target="_blank">Cucumber</a> introduced in earlier <a href="http://jperala.fi/bdd-with-cucumber-java-maven-and-selenium/">post</a>. As a difference to Cucumber, the JBehave comes with Jbehave-web-selenium library that provide integration with Selenium and <a href="http://www.seleniumhq.org/projects/webdriver/" target="_blank">WebDriver</a> APIs.</p>
<p>With jbehave-web-selenium library the lifecycle of WebDriver instance in tests is controlled via *WebDriverSteps classes. By default the JBehave provides 3 alternative lifecycle models:</p>
<ul>
<li><strong>PerStoriesWebDriverSteps</strong>, which initiates the WebDriver instance before execution of any stories and finalize the driver after all stories have been executed. Using PerStoriesWebDriverSteps enables execution of whole test suite (all stories and their scenarios) with same WebDriver instance.</li>
<li><strong>PerStoryWebDriverSteps</strong>, which initiates and finalizes the WebDriver instance for each  story. Using PerStoryWebDriverSteps enables executions of each story with own WebDriver instance, while the same driver instance is used between scenarios of that same story.</li>
<li><strong>PerScenarioWebDriverSteps</strong>, which initiates and finalizes the WebDriver instance for each scenario of each story.</li>
</ul>
<p><!--more--></p>
<p>Which is the most suitable lifecycle model depends on the needs of the test. Using PerScenarioWebDriverSteps makes the tests most deterministic and robust as each individual scenario is executed with freshly initialized WebDriver instance and in new browser window, whereas PerStoriesWebDriverSteps is faster in large test sets as initialization of WebDriver and browser is made only once during whole test execution (or once per story when using PerStoryWebDriverSteps).</p>
<p>When using PerStoriesWebDriverSteps or PerStoryWebDriverSteps it is definitely good practice to clear browser cookies before or after each story:</p>
<pre class="lang:java decode:true" title="Clear browser cookies">@BeforeScenario
public void beforeScenario() {
    driver.manage().deleteAllCookies();
}</pre>
<p>However, in some rare cases using same WebDriver instance between multiple tests can cause some unwanted trouble and undeterministic behavior caused by lingering cookies which can cause e.g. logged-in user to remain its session. In these cases using PerScenarioWebDriverSteps is the most suitable and robust alternative.</p>
<p>When running parameterized scenarios  (i.e. example scenarios) with multiple example values, similar issues may arise within different parameterized executions of the same scenario. In these cases it would be handy to initialize the WebDriver separately for each parameterized run of the scenario. However, by default JBehave does not provide lifecycle step supporting this type of behavior. Luckily this can be easily added by creating PerExampleWebDriverSteps class, that handles initialization of the WebDriverProvider in both NORMAL and EXAMPLE alternatives of @BeforeScenario annotation:</p>
<pre class="lang:java decode:true" title="Lifecycle class to initialize WebDriver for earch scenario example.">package fi.jperala.jbehave.steps;

import org.jbehave.core.annotations.AfterScenario;
import org.jbehave.core.annotations.BeforeScenario;
import org.jbehave.core.annotations.ScenarioType;
import org.jbehave.web.selenium.WebDriverProvider;
import org.jbehave.web.selenium.WebDriverSteps;

public class PerExampleWebDriverSteps extends WebDriverSteps {
    
    private boolean initialized;

    public PerExampleWebDriverSteps(WebDriverProvider driverProvider) {
        super(driverProvider);
    }

    @BeforeScenario(uponType = ScenarioType.NORMAL)
    public void beforeNormal() throws Exception {
        driverProvider.initialize();
        initialized = true;
    }

    @BeforeScenario(uponType = ScenarioType.EXAMPLE)
    public void beforeExample() throws Exception {
        // do not initialize if already done
        if(!initialized) {
            driverProvider.initialize();
            initialized = true;
        }
    }

    @AfterScenario(uponType = ScenarioType.EXAMPLE)
    public void afterExample() throws Exception {
        driverProvider.end();
        initialized = false;
    }

    @AfterScenario(uponType = ScenarioType.NORMAL)
    public void afterNormal() throws Exception {
        // do not finalize if already done
        if(initialized) {
            driverProvider.end();
            initialized = false;
        }
    }
}
</pre>
<p>Hopefully this provides short insight to managing lifecycle of WebDriver instance with JBehave and how the default licecycles can be extended also to support initialization of the WebDriver for each example of parameterized scenarios.</p>
