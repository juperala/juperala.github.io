---
layout: post
title: JBehave and managing WebDriver initialization
date: 2016-01-14 22:44:26.000000000 +02:00
author: juperala
"header-img": "img/post-bg-06.jpg"
published: true
---

[JBehave](http://jbehave.org/) is a BDD framework similar to [Cucumber](https://cucumber.io/) introduced in earlier
[post]({% post_url 2015-07-07-bdd-with-cucumber-java-maven-and-selenium %}). As a difference to Cucumber, the JBehave comes with Jbehave-web-selenium library that provide integration with [Selenium WebDriver API](http://www.seleniumhq.org/projects/webdriver/).

With jbehave-web-selenium library the lifecycle of WebDriver instance in tests is controlled via *WebDriverSteps* classes. By default the JBehave provides 3 alternative lifecycle models:

+ **PerStoriesWebDriverSteps**, which initiates the WebDriver instance before execution of any stories and finalize the driver after all stories have been executed. Using PerStoriesWebDriverSteps enables execution of whole test suite (all stories and their scenarios) with same WebDriver instance.
+ **PerStoryWebDriverSteps**, which initiates and finalizes the WebDriver instance for each  story. Using PerStoryWebDriverSteps enables executions of each story with own WebDriver instance, while the same driver instance is used between scenarios of that same story.
+ **PerScenarioWebDriverSteps**, which initiates and finalizes the WebDriver instance for each scenario of each story.

Which is the most suitable lifecycle model depends on the needs of the test. Using *PerScenarioWebDriverSteps* makes the tests most deterministic and robust as each individual scenario is executed with freshly initialized WebDriver instance and in new browser window, whereas *PerStoriesWebDriverSteps* is faster in large test sets as initialization of WebDriver and browser is made only once during whole test execution (or once per story when using *PerStoryWebDriverSteps*).

When using PerStoriesWebDriverSteps or PerStoryWebDriverSteps it is definitely good practice to clear browser cookies before or after each story:

{% highlight java %}
@BeforeScenario
public void beforeScenario() {
    driver.manage().deleteAllCookies();
}
{% endhighlight %}

However, in some rare cases using same WebDriver instance between multiple tests can cause some unwanted trouble and undeterministic behavior caused by lingering cookies which can cause e.g. logged-in user to remain its session. In these cases using PerScenarioWebDriverSteps is the most suitable and robust alternative.

When running parameterized scenarios  (i.e. example scenarios) with multiple example values, similar issues may arise within different parameterized executions of the same scenario. In these cases it would be handy to initialize the WebDriver separately for each parameterized run of the scenario. However, by default JBehave does not provide lifecycle step supporting this type of behavior.

Luckily this can be easily added by creating PerExampleWebDriverSteps class, that handles initialization of the WebDriverProvider in both NORMAL and EXAMPLE alternatives of @BeforeScenario annotation:

{% highlight java %}
package fi.jperala.jbehave.steps;

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
{% endhighlight %}

Hopefully this provides short insight to managing lifecycle of WebDriver instance with JBehave and how the default licecycles can be extended also to support initialization of the WebDriver for each example of parameterized scenarios.
