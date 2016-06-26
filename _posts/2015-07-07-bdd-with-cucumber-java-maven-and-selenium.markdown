---
layout: post
title: BDD with Cucumber, Java, Maven and Selenium
date: 2015-07-07 14:24:13.000000000 +03:00
author: jperala
header-img: "img/post-bg-04.jpg"
comments: true
tags:
- BDD
- Behavior-Driven development
- Java
- Maven
- Cucumber
- Selenium
---
[Cucumber](https://cucumber.io/) provides flexible framework for writing BDD-style automated acceptance tests. Cucumber was originally implemented in Ruby, but currently implementation exists for various languages including Ruby, Java, .NET, Flex and many more. This tutorial presents example of implementing Cucumber acceptance tests in Java using Cucumber-JVM, Maven and Selenium.

In this tutorial, the [Vaadin Addressbook tutorial](https://github.com/vaadin/addressbook) application is used as test target for which the tests are implemented.

TLDR: Give me the ready solution
--------------------------------

The test code implemented in this tutorial, with a clone of Vaadin Addressbook application, is available from [my GitHub account](https://github.com/juperala/addressbook). If you want to jump right into running tests, you can clone the ready solution and execute tests using maven:

{% highlight sh %}
git clone https://github.com/juperala/addressbook.git
cd addressbook
mvn verify
{% endhighlight %}

Step 0: Clone the application and add dependencies
--------------------------------------------------

To get started in this tutorial, we need to clone the test target code from GitHub:

{% highlight sh %}
git clone https://github.com/vaadin/addressbook.git
cd addressbook
{% endhighlight %}

### Run the application

To get familiar with the Addressbook application, you can start-up the application with maven:

{% highlight sh %}
mvn jetty:run
{% endhighlight %}

When started, the application can be accessed via browser in localhost:8080:
[![Vaadin Addressbook application]({{ site.baseurl }}/img/2015-07-07/cucumber-addressbook-small.png)]({{ site.baseurl }}/img/2015-07-07/cucumber-addressbook.png)

### Add test dependencies

To begin our test development, we need to add needed JUnit, Cucumber and Selenium libraries in the project */pom.xml* file as dependencies. Add following dependencies:

{% highlight xml %}
    <dependencies>
        ...
        <dependency>
            <groupId>junit</groupId>
            <artifactId>junit</artifactId>
            <version>4.12</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>info.cukes</groupId>
            <artifactId>cucumber-java</artifactId>
            <version>1.2.2</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>info.cukes</groupId>
            <artifactId>cucumber-junit</artifactId>
            <version>1.2.2</version>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.seleniumhq.selenium</groupId>
            <artifactId>selenium-java</artifactId>
            <version>2.45.0</version>
            <scope>test</scope>
            <type>jar</type>
        </dependency>
        <dependency>
            <groupId>org.seleniumhq.selenium</groupId>
            <artifactId>selenium-firefox-driver</artifactId>
            <version>2.45.0</version>
            <scope>test</scope>
            <type>jar</type>
        </dependency>
    </dependencies>
{% endhighlight %}

Step 1: Write Cucumber acceptance tests
---------------------------------------

First, we need to define the tests for Cucumber. Cucumber uses Gherkin DSL (Domain Specific Language) parser to parse domain-specific plain text test specification. The plain text test specification follow the BDD-style *"Given...When...Then..."* pattern to define pre-conditions, system behavior and expected post-condititons.

After familiarization with the Addressbook application, we identified three main features of the Addressbook application:

+ Adding persons to contact list,
+ Searching persons from contact list, and
+ Updating persons in the contact list.

Next we create Cucumber test specification for these features. In Cucumber-JVM the test specifications for features are stored by default in */src/test/resources/&lt;package&gt;/&lt;feature-name&gt;.feature* directory.

Define add feature in file: */src/test/resources/feature/contact/add/add.feature*:

{% highlight text %}
Feature: Add person to contacts
    Addressbook must be able to support adding persons in contact list.

    Scenario: Add new person
        Given the system is initialized
        When new person with firstname 'Teppo' and lastname 'Testaaja' is added
        Then person with firstname 'Teppo' and lastname 'Testaaja' exist in contacts

    Scenario: Cancel addition
        Given the system is initialized
        When adding new person with firstname 'Lasse' and lastname 'Laaka' is started but operation is canceled
        Then person with firstname 'Lasse' and lastname 'Laaka' does not exist in contacts
{% endhighlight %}

Define search feature in file: */src/test/resources/feature/contact/search/search.feature*:

{% highlight text %}
Feature: Search person in contacts
    Addressbook must be able to allow searching of contacts.

    Scenario: Search
        Given the system is initialized
            And a person with firstname 'Osuma' and lastname 'Haku'
            And another person with firstname 'Huti' and lastname 'Haku'
        When search 'Osuma' is made
        Then person with firstname 'Osuma' and lastname 'Haku' exist in contacts
            And number of contacts is 1
        When search is cleared
            And search 'Haku' is made
        Then number of contacts is 2
{% endhighlight %}

Define update feature in file: */src/test/resources/feature/contact/update/update.feature*:

{% highlight text %}
Feature: Update person in contacts
    Addressbook must be able to update existing contacts.

    Scenario: Update existing person
        Given the system is initialized
            And a person with firstname 'Veikko' and lastname 'Varamies'
        When first person in contacts is updated with firstname 'Veikko' and lastname 'Varamies-Patela'
        Then person with firstname 'Veikko' and lastname 'Varamies-Patela' exist in contacts
            And person with firstname 'Veikko' and lastname 'Varamies' does not exist in contacts

    Scenario: Cancel update
        Given the system is initialized
          And a person with firstname 'Keijo' and lastname 'Kekkonen'
        When updating first person in contacts with firstname 'Keijo' and lastname 'Kekkonen-Patela' is started but operation is canceled
        Then person with firstname 'Keijo' and lastname 'Kekkonen' exist in contacts
          And person with firstname 'Keijo' and lastname 'Kekkonen-Patela' does not exist in contacts
{% endhighlight %}

Step 2: Implement Java tests for defined features
-------------------------------------------------

After defining the scenarios, we need to create corresponding test classes in Java. In this tutorial we are using Cucumber JUnit runner to execute tests using JUnit test framework and we need to define the corresponding test classes for the add, search and update features:
Create add feature test: */src/test/java/feature/contact/add/AddContactIT.java*:

{% highlight java %}
package feature.contact.add;

import cucumber.api.CucumberOptions;
import org.junit.runner.RunWith;
import cucumber.api.junit.Cucumber;

/**
 * Test header for add feature.
 *
 * @author Juho Perälä
 */
@RunWith(Cucumber.class)
@CucumberOptions(
        plugin = {"pretty", "html:target/results/add"}
        , glue = {"steps"}
)
public class AddContactIT {
}
{% endhighlight %}

Create search feature test: */src/test/java/feature/contact/search/SearchContactIT.java*:

{% highlight java %}
package feature.contact.search;

import cucumber.api.CucumberOptions;
import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

/**
 * Test header for search feature.
 *
 * @author Juho Perälä
 */
@RunWith(Cucumber.class)
@CucumberOptions(
        plugin = {"pretty", "html:target/results/search"}
        , glue = {"steps"}
)
public class SearchContactIT {
}
{% endhighlight %}

Create update feature test: */src/test/java/feature/contact/update/UpdateContactIT.java*:

{% highlight java %}
package feature.contact.update;

import cucumber.api.CucumberOptions;
import org.junit.runner.RunWith;
import cucumber.api.junit.Cucumber;

/**
 * Test header for update feature.
 *
 * @author Juho Perälä
 */
@RunWith(Cucumber.class)
@CucumberOptions(
        plugin = {"pretty", "html:target/results/update" }
        , glue = { "steps" }
)
public class UpdateContactIT {
}
{% endhighlight %}

Step 3: Implement Selenium mapping to Addressbook
-------------------------------------------------

Next we need to create support for controlling the Addressbook target application using Selenium. In this tutorial we used PageObject pattern to separate the Selenium functionality into a separate page object class.

Create Addressbook page object: */src/test/java/pages/AddressBookPage.java*:

{% highlight java %}
package pages;

import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.support.FindBy;
import org.openqa.selenium.support.ui.ExpectedCondition;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.util.Iterator;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * Page object for addressbook web page.
 *
 * @author Juho Perälä
 */
public class AddressBookPage {

    private static final int WAIT_SECS = 10;

    protected WebDriver driver;

    @FindBy(css = ".v-button")
    private WebElement newButton;

    @FindBy(css = ".primary")
    private WebElement saveButton;

    @FindBy(css = "div.v-slot:nth-child(3) > div:nth-child(1)")
    private WebElement cancelButton;

    @FindBy(css = ".v-horizontallayout > div > div > .v-textfield")
    private WebElement searchField;

    @FindBy(xpath = "//*[contains(@class, 'v-formlayout')]/table/tbody/tr[2]/td[3]/input")
    private WebElement fNameField;

    @FindBy(xpath = "//*[contains(@class, 'v-formlayout')]/table/tbody/tr[3]/td[3]/input")
    private WebElement lNameField;

    @FindBy(xpath = "//*[contains(@class, 'v-formlayout')]/table/tbody/tr[4]/td[3]/input")
    private WebElement phoneField;

    @FindBy(xpath = "//*[contains(@class, 'v-formlayout')]/table/tbody/tr[5]/td[3]/input")
    private WebElement emailField;

    @FindBy(xpath = "//*[contains(@class, 'v-formlayout')]/table/tbody/tr[6]/td[3]/div/input")
    private WebElement birthdayField;

    @FindBy(css = ".v-grid-tablewrapper > table > tbody > tr:first-child > td:nth-child(1)")
    private WebElement firstContactFirstName;

    @FindBy(css = ".v-grid-tablewrapper > table > tbody > tr:first-child > td:nth-child(2)")
    private WebElement firstContactLastName;

    @FindBy(css = ".v-grid-tablewrapper > table > thead > tr:first-child > th:first-child")
    private WebElement orderByFirstName;

    public AddressBookPage(WebDriver driver) {
        this.driver = driver;
        driver.manage().timeouts().implicitlyWait(WAIT_SECS, TimeUnit.SECONDS);
    }

    public void open(String url) {
        driver.get(url);
    }

    public void close() {
        driver.quit();
    }

    public String getTitle() {
        return driver.getTitle();
    }

    public AddressBookPage addContact(String fName, String lName) {
        return addContact(fName, lName, false);
    }

    public AddressBookPage addContact(String fName, String lName, boolean cancelOperation) {
        newButton.click();
        fNameField.sendKeys(fName);
        lNameField.sendKeys(lName);
        // TODO: fixed for example
        phoneField.sendKeys("+123-123-1231234");
        // TODO: fixed for example
        emailField.sendKeys(fName + "." + lName + "@test.ts");
        // TODO: fixed for example
        birthdayField.sendKeys("1/1/15");
        if (cancelOperation) {
            cancelButton.click();
        } else {
            saveButton.click();
        }
        return this;
    }

    public AddressBookPage searchContacts(String searchTerm) {
        searchField.sendKeys(searchTerm);
        // TODO: Implement explicit wait to check when search Javascript done
        try {
            Thread.sleep(1000);
        } catch (Exception e) {
        }
        return this;
    }

    public AddressBookPage clearSearch() {
        searchField.clear();
        return this;
    }

    public AddressBookPage updateFirstContact(String firstName, String lastName) {
        return updateFirstContact(firstName, lastName, false);
    }

    public AddressBookPage updateFirstContact(String firstName, String lastName, boolean cancelOperation) {
        firstContactFirstName.click();
        fNameField.clear();
        fNameField.sendKeys(firstName);
        lNameField.clear();
        lNameField.sendKeys(lastName);
        if (cancelOperation) {
            cancelButton.click();
        } else {
            saveButton.click();
        }
        return this;
    }

    public String getFirstNameOfFirstContactInList() {
        return firstContactFirstName.getText();
    }

    public String getLastNameOfFirstContactInList() {
        return firstContactLastName.getText();
    }

    public AddressBookPage orderContactsByFirstName() {
        orderByFirstName.click();
        return this;
    }

    public boolean isContactPresent(String firstName, String lastName) {
        List<WebElement> contacts = driver.findElements(By.cssSelector(".v-grid-tablewrapper > table > tbody > tr"));
        Iterator<WebElement> iter = contacts.iterator();

        while (iter.hasNext()) {
            WebElement contact = iter.next();
            if (firstName.equals(contact.findElement(By.cssSelector("td:nth-child(1)")).getText())) {
                if (lastName.equals(contact.findElement(By.cssSelector("td:nth-child(2)")).getText())) {
                    // contact match firstname + lastname, consider as match in this example
                    return true;
                }
            }
        }
        // no matching contact found
        return false;
    }

    public int getContactCount() {
        return driver.findElements(By.cssSelector(".v-grid-tablewrapper > table > tbody > tr")).size();
    }
}
{% endhighlight %}

Step 4: Map Cucumber test steps to page object
----------------------------------------------

After creating the test classes and Selenium page object, we need to implement Cucumber test steps and map these to the created Selenium page object. For clarify and reuse, we define the steps in separate *steps* package. As seen in the Step 2, we used *@CucumberOptions* annotation and *glue* attribute to define the location where Cucumber tries to find corresponding step definitions.

Create Java step definition file: */src/test/java/steps/ContactSteps.java*:

{% highlight java %}
package steps;

import cucumber.api.java.After;
import cucumber.api.java.Before;
import cucumber.api.java.en.Given;
import cucumber.api.java.en.Then;
import cucumber.api.java.en.When;
import org.junit.Assert;
import org.openqa.selenium.firefox.FirefoxDriver;
import org.openqa.selenium.support.PageFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import pages.AddressBookPage;

/**
 * Definition of Cucumber test steps.
 * Accessing addressbook webpage using Selenium is separated as own page object for clarity.
 *
 * @author Juho Perälä
 */
public class ContactSteps {
    private static final Logger LOG = LoggerFactory.getLogger(ContactSteps.class);
    private static final String BASE_URL = "http://localhost:8080/";

    private AddressBookPage page;

    @Before
    public void beforeScenario() {
        page = PageFactory.initElements(new FirefoxDriver(), AddressBookPage.class);
    }

    @After
    public void afterScenario() {
        page.close();
    }

    @Given("^the system is initialized$")
    public void initializeSystem() {
        LOG.debug("Initializing system.");
        page.open(BASE_URL);
    }

    @Given(".+person with firstname '(.+)' and lastname '(.+)'$")
    public void initContact(final String firstName, final String lastName) {
        LOG.debug("Adding default contact {} {}.", firstName, lastName);
        page.addContact(firstName, lastName);
    }

    @When("^new person with firstname '(.+)' and lastname '(.+)' is added$")
    public void addContact(final String firstName, final String lastName) {
        LOG.debug("Adding contact {} {}.", firstName, lastName);
        page.addContact(firstName, lastName);
    }

    @When("^adding new person with firstname '(.+)' and lastname '(.+)' is started but operation is canceled$")
    public void addNewContactButCancelProcess(final String firstName, final String lastName) {
        LOG.debug("Start adding contact {} {} but cancel operation.", firstName, lastName);
        page.addContact(firstName, lastName, true);
    }

    @When("^first person in contacts is updated with firstname '(.+)' and lastname '(.+)'$")
    public void updateFirstContact(final String firstName, final String lastName) {
        LOG.debug("Updating first contact to {} {}.", firstName, lastName);
        page.updateFirstContact(firstName, lastName);
    }

    @When("^updating first person in contacts with firstname '(.+)' and lastname '(.+)' is started but operation is canceled$")
    public void updateFirstContactButCancelProcess(final String firstName, final String lastName) {
        LOG.debug("Start updating first contact to {} {} but cancel operation.", firstName, lastName);
        page.updateFirstContact(firstName, lastName, true);
    }

    @When("^contact list is ordered$")
    public void orderContacts() {
        LOG.debug("Ordering contacts.");
        page.orderContactsByFirstName();
    }

    @When("^search is cleared$")
    public void clearSearch() {
        LOG.debug("Clearing search.");
        page.clearSearch();
    }

    @When("^search '(.+)' is made$")
    public void orderContacts(final String search) {
        LOG.debug("Searching contacts with query {}", search);
        page.searchContacts(search);
    }

    @Then("^first person in contacts should have firstname '(.+)' and lastname '(.+)'$")
    public void verifyFirstContact(final String firstName, final String lastName) {
        LOG.debug("Verifying first contact in list.");
        Assert.assertEquals("First contact in addressbook has wrong firstname.", firstName, page.getFirstNameOfFirstContactInList());
        Assert.assertEquals("First contact in addressbook has wrong lastname.", lastName, page.getLastNameOfFirstContactInList());
    }

    @Then("^last person in contacts should have firstname '(.+)' and lastname '(.+)'$")
    public void verifyLastContact(final String firstName, final String lastName) {
        LOG.debug("Verifying last contact in list.");
        Assert.assertEquals("Last contact in addressbook has wrong firstname.", firstName, page.getFirstNameOfFirstContactInList());
        Assert.assertEquals("Last contact in addressbook has wrong lastname.", lastName, page.getLastNameOfFirstContactInList());
    }

    @Then("^number of contacts is (\d+)$")
    public void verifyContactCount(final int count) {
        LOG.debug("Verifying contacts count, expected {}.", count);
        Assert.assertEquals("Contact count mismatch.", count, page.getContactCount());
    }

    @Then("^person with firstname '(.+)' and lastname '(.+)' exist in contacts$")
    public void verifyContactExists(final String firstName, final String lastName) {
        LOG.debug("Verifying person {} {} present in the contacts", firstName, lastName);
        Assert.assertTrue("Person not found in contacts.", page.isContactPresent(firstName, lastName));
    }

    @Then("^person with firstname '(.+)' and lastname '(.+)' does not exist in contacts$")
    public void verifyContactDoesNotExist(final String firstName, final String lastName) {
        LOG.debug("Verifying person {} {} not present in the contacts", firstName, lastName);
        Assert.assertFalse("Person was found in contacts.", page.isContactPresent(firstName, lastName));
    }
}
{% endhighlight %}

Step 5: Configure execution of tests in Maven
---------------------------------------------

To execute tests, we need to configure the execution of tests in project */pom.xml* file. We defined the tests as integration tests (**IT.java*) and use the *[maven-failsafe-plugin](https://maven.apache.org/surefire/maven-failsafe-plugin/)* to execute these tests as part of the maven integration-test lifecycle. In addition, *[jetty-maven-plugin](http://www.eclipse.org/jetty/documentation/current/jetty-maven-plugin.html)* is reconfigured to start the test target in maven pre-integration-test lifecycle, and stop it in post-integration-test lifecycle.

Update */pom.xml* with following build plugins:

{% highlight xml %}
<build>
        <plugins>
            ...
            <plugin>
                <groupId>org.eclipse.jetty</groupId>
                <artifactId>jetty-maven-plugin</artifactId>
                <version>9.2.3.v20140905</version>
                <configuration>
                    <scanIntervalSeconds>10</scanIntervalSeconds>
                    <stopPort>8005</stopPort>
                    <stopKey>STOP</stopKey>
                </configuration>
                <executions>
                    <execution>
                        <id>start-jetty</id>
                        <phase>pre-integration-test</phase>
                        <goals>
                            <goal>start</goal>
                        </goals>
                        <configuration>
                            <scanIntervalSeconds>0</scanIntervalSeconds>
                            <daemon>true</daemon>
                        </configuration>
                    </execution>
                    <execution>
                        <id>stop-jetty</id>
                        <phase>post-integration-test</phase>
                        <goals>
                            <goal>stop</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-failsafe-plugin</artifactId>
                <version>2.18.1</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>integration-test</goal>
                            <goal>verify</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
        </plugins>
    </build>
{% endhighlight %}

Step 6: All done, Enjoy!
------------------------

Now we have a working Cucumber-JVM example using JUnit, Maven and Selenium. Execute tests via maven:

{% highlight sh %}
mvn verify
{% endhighlight %}

and observe the results:
[![test result]({{ site.baseurl }}/img/2015-07-07/cucumber-build-small.png)]({{ site.baseurl }}/img/2015-07-07/cucumber-build.png)

The html formatted Cucumber test reports can be found from the */target/results/* folder as defined in *@CucumberOptions* in Step 2.

Enjoy!
