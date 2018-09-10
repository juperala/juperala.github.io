---
layout: post
title: Review Your Test Automation Code
date: 2018-09-11 00:34:00 +03:00
author: jperala
"header-img": "img/post-bg-05.jpg"
published: true
comments: true
tags:
- Test automation
- Code Review
- Quality
---
Doing test automation is about writing code. Test automation code can be easily treated as second-class citizen. As it's not delivered to customer, development is often less formalized and may lack the scrutiny and quality practices otherwise applied in the organization. It's also often first code many junior developers and testers start their journey into programming.

However, when it comes to creating valuable and maintainable automation, the automation code should be well implemented with maintainability in mind. Tests should be highly reliable as any false positives, false negatives or test flakiness will break the trusts towards the automation results.

One way to improve automation quality is to apply code review practices where automated tests are reviewed by your peers. With code review practices you can identify issues in automation that could affect test results and stability.

This post will present list of possible problem areas in automation code to look for in code reviews.

# Things to look out in code review

## It's just code
As said, test automation is just code. Therefore common code review guidelines can be applied in the review process. Check out your organization review guidelines and practices if not familiar with doing reviews. For example, common things to look for include:
* Is the code understandable? Is there unnecessary complexity that could be simplified?
* Are functions or classes too big, can those be broken down to smaller parts?
* Does code units have too many responsibilities? Single responsibility principle?
* Does the code follow DRY (Don't Repeat Yourself) pattern? Is there duplication in the code?
* Does the code follow common coding standards and conventions?

## Issues specific to test code
In addition of generic code review issues to look for, there are many problem areas and issues in the test logic that can be identified in code reviews. Following chapters describe few common categories of what to look out for.

The issues are demonstrated with code example using Selenium WebDriver and Java, but the presented issue categories are not specific to any particular language or automation framework per se.

### Bad assertions
One supprisingly common mistake seen in test scripts is forgotten assersions. Lack of assertion can make your test to produce false positive test results.
{% highlight java %}
    private void submitIsDisplayed() {
        WebElement button = driver.findElement(By.id("submit"));
        // check that element is displayed
        button.isDisplayed();  // MISSING ASSERTION
    }
{% endhighlight %}

### Retrys
Another issue commonly seen is trying to fix test stability issues by retrying test steps in case of exception. Usually this is a indication of brittle automation code and lack of understanding of the application internal behavior. Identify what is the application behaviour causing test step to fail and create needed wait or missing test logic to handle it reliably.
{% highlight java %}
    private void inputAmount(String amount) {
        try {
            WebElement field = driver.findElement(By.id("amount"));
            field.sendKeys(amount);
        } catch(StaleElementReferenceException e) {
            // INPUT FAILED, RETRYING
            WebElement field = driver.findElement(By.id("amount"));
            field.sendKeys(amount);
        }
    }
{% endhighlight %}

### Sleeps and fixed delays
Very similar to retrys described above are fixed delays (sleeps) commonly seen to fix test stability issues. Identify what is the application event causing test step to fail and create appropriate wait for it. Don't slow down tests with fixed delays.

{% highlight java %}
    private void acceptCookie() throws InterruptedException {
        // FIXED DELAY
        Thread.sleep(5000);
        WebElement cookieButton = driver.findElement(By.id("accept"));
        cookieButton.click();
    }
{% endhighlight %}

### Hard-coded values and configurations
One thing sure is that you never know where your tests will be run in the future. Therefore automation code should be easily configurable. What if you need to test in different environment? With different user? Or with different browser? Make your tests configurable from the get-go by avoiding fixed URLs, drivers, etc.

{% highlight java %}
    private void init() {
        driver = new FirefoxDriver(); // FIXED BROWSER TYPE
        driver.get("https://192.168.1.5/app"); // FIXED URL
    }
{% endhighlight %}

### Wrong level of abstraction
Commonly seen issue with BDD-based automation is wrong level of abstraction. In BDD the story files and scenarios should serve as examples describing your product behavior without detailed implementation mechanics - allowing common understanding (and means of communication) of product behaviour for different stakeholders.

Implementation specific scenarios often indicate also that BDD is only created for automation purposes rather than serving as common documentation for the whole development process. As such, having BDD layer in automation is merely just an extra boilerplate to be maintained with no real value.

{% highlight gherkin %}
Scenario: Application can be started
Given application is opened
When user clicks element "//button[@title='Start']" # SPECIFICS TO UI IMPLEMENTATION
Then element "#app > div.started" is visible        # SPECIFICS TO UI IMPLEMENTATION
{% endhighlight %}

### Lack of atomicity
Another thing to look out for is chained tests that can not be run without each other. Having chained tests make the understanding and debugging of tests more complicated and also causes failure propagation. Failure of single test can lead to failure of all the subsequent tests also.
{% highlight java %}
@FixMethodOrder(MethodSorters.NAME_ASCENDING)
public class ChainedTests {

    // ... init ....

    @Test
    public void t1_canLoadPage() {
        driver.get(getAppUrl());
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("password")));
    }

    // DEPENDENT ON T1_canLoadPage
    @Test
    public void t2_canLogin() {
        driver.findElement(By.id("userid")).sendKeys(userId);
        driver.findElement(By.id("password")).sendKeys(password);
        driver.findElement(By.id("login")).click();
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("order")));
    }

    // DEPENDENT ON T1_canLoadPage and T2_canLogin
    @Test
    public void t3_canPlaceAnOrder() {
        driver.findElement(By.id("order")).click();
        wait.until(ExpectedConditions.visibilityOfElementLocated(By.id("confirmation")));
    }
}
{% endhighlight %}

### Unreliable selectors
UI-based tests usually use some sort of selectors to identify the elements to interact with. Using unreliable and vague selectors can make your tests brittle and cause test failures even in case of minor UI changes around your test scope. For example, using absolute xpath or css locator can break when extra tag is added in the UI as parent or sibling of an particular element.

Add unique locators in the product as needed to support testing. If this is not possible, identify stable ways to locate elements. Avoid using absolute css or xpath locators that are likely to break easily.

{% highlight java %}
    private String getDisclaimer() {
        // ABSOLUTE XPATH LOCATOR THAT GETS EASILY BROKEN
        By disclaimer = By.xpath("html/body/div[1]/section/div[1]/div/div/div/div[1]/div/div/div/div/div[3]/div[1]/div/h4");
        return driver.findElement(disclaimer).getText();
    }
{% endhighlight %}

# Opportunity for learning
Code reviews should not be seen only as a mean to identify problems in code. Reading others code and getting feedback for your own is a great way to improve your automation skills. There's always so much to learn from each others. 

# Means to an End
The presented list aims to identify issues that can cause your test to be brittle, false, or make them hard to maintain. However, it doesn't aim to be ultimate truth about what is considered as bad practice. In some context using the presented approaches may be applicable or even only way to create workaround to get tests up and running. Sometimes it can be also reasoned for writing quick-n-dirty tests to verify something only once. Means to an end.