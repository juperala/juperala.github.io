---
layout: post
title: WebDriver locator performance - Is Edge really that fast?
date: 2016-04-11 20:03:00.000000000 +02:00
author: jperala
"header-img": "img/post-bg-01.jpg"
published: true
tags:
- WebDriver
- Selenium
- performance
- Edge
- Java
---

With colleagues we had discussion about the performance of different WebDriver locators. According some sources especially the XPATH locator can have slow performance compared to CSS and other locators. To get rough idea about the performance of different locators I decided to make a quick test on Firefox, Chrome and Edge.

Test case
---------
Test measures time used to find an element from [Twitter](http://twitter.com) front page using different selectors. The finding of element is repeated 100 times to get more reproducible and statistically reliable results. The locators used in test were:

+ By.name("session[username_or_email]")
+ By.className("email-input")
+ By.id("signin-email")
+ By.linkText("Forgot password?")
+ By.xpath("//*[@id=\"signin-email\"]")
+ By.cssSelector("input.text-input.email-input")

Test Environment
----------------
+ Windows 10
  + Firefox 45.0.1
  + Chrome 49.0.2623.110
  + Edge 25.10586.0.0
  + Java 8 (64bit, version 1.8.0_31)
+ WebDriver 2.53.0
  + FirefoxDriver 2.53.0
  + ChromeDriver 2.21.371459
  + MicrosoftWebDriver 3.14316

Results
-------
Here are the measurement results. The time is total time of 100 findElement() method calls using the given locator. The slowests execution times per each browser are **bolded**.

|**Locator**|**Firefox**|**Chrome**|**Edge**|
|**name**|1377 ms|929 ms|204 ms|
|**className**|1795 ms|902 ms|199 ms|
|**id**|1600 ms|851 ms|**262 ms**|
|**linkText**|**9056 ms**|**1522 ms**|238 ms|
|**xpath**|2229 ms|919 ms|247 ms|
|**cssSelector**|1280 ms|809 ms|219 ms|

Summary
-------

The executed test is just a quick measurement to get rough idea about the locator performance. The performance is naturally affected by context (e.g. page content, locator queries and test environment), and therefore the results should not be used as conclusive results but rather as starting point for additional analysis.

However, what can be seen from the results is that the performance is highly affected by the used browser. In fact, the used browser seems to be more dominant factor for the performance than the used locator type. Supprisingly the Edge seems to beat Firefox and Chrome in performance by far. Can Edge really be this fast?

Another finding was very poor performance of linkText -locator in Firefox, whereas is Chrome and Firefox no similar performance drop was observable. Also bit supprisingly, the id -locator was not always the fastest locator (as we  initially expected).

As conclusion, the performance of locators in most cases has only minimal (or none) effect on the test execution time and result varies on each browser. In most normal test cases the test execution times are affected on ten- to hundredfolds by the wait strategies used in tests.

Test code
---------
If interested to carry out your own additional measurements, below is the test case used for the measurements.

{% highlight java %}
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized.Parameters;
import org.junit.runners.Parameterized;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.edge.EdgeDriver;
import org.openqa.selenium.firefox.FirefoxDriver;

import java.time.format.TextStyle;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.concurrent.TimeUnit;

@RunWith(Parameterized.class)
public class WebDriverTest {

    private static final String[] BROWSERS = {"firefox", "chrome", "edge"};
    private static final int TEST_COUNT = 100;

    WebDriver driver;
    By by;
    String locator;
    String browser;

    @Parameters
    public static Collection locators() {
        List<Object[]> params = new ArrayList<>();
        for (String browser : BROWSERS) {
            params.add(new Object[]{browser, By.name("session[username_or_email]"), "name"});
            params.add(new Object[]{browser, By.className("email-input"), "className"});
            params.add(new Object[]{browser, By.id("signin-email"), "id"});
            params.add(new Object[]{browser, By.linkText("Forgot password?"), "linkText"});
            params.add(new Object[]{browser, By.xpath("//*[@id=\"signin-email\"]"), "xpath"});
            params.add(new Object[]{browser, By.cssSelector("input.text-input.email-input"), "cssSelector"});
        }
        return params;
    }

    public WebDriverTest(String browser, By by, String locator) {
        this.browser = browser;
        this.by = by;
        this.locator = locator;
    }

    @Before
    public void before() {
        switch (browser) {
            case "firefox":
                driver = new FirefoxDriver();
                break;
            case "chrome":
                driver = new ChromeDriver();
                break;
            case "edge":
                driver = new EdgeDriver();
                break;
            default:
                break;
        }
    }

    @After
    public void afterClass() {
        driver.close();
        driver.quit();
    }

    @Test
    public void locatorPerformance() throws InterruptedException {
        // load page
        driver.get("http://twitter.com");

        // dry-run and let browser settle a bit
        driver.findElement(by);
        TimeUnit.SECONDS.sleep(5);

        // do measurements
        long start = System.currentTimeMillis();
        for (int i = 0; i < TEST_COUNT; i++) {
            driver.findElement(by);
        }
        long stop = System.currentTimeMillis();
        System.out.println(browser + ": Locator " + locator + " execution time: " + (stop - start));
    }
}
{% endhighlight %}
