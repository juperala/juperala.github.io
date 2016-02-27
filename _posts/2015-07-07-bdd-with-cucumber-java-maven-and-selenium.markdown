---
layout: post
title: BDD with Cucumber, Java, Maven and Selenium
date: 2015-07-07 14:24:13.000000000 +03:00
author: juperala
header-img: "img/post-bg-06.jpg"
---
<p><a href="https://cucumber.io/" target="_blank">Cucumber</a> provides flexible framework for writing BDD-style automated acceptance tests. Cucumber was originally implemented in Ruby, but currently implementation exists for various languages including Ruby, Java, .NET, Flex and many more. This tutorial presents example of implementing Cucumber acceptance tests in Java using Cucumber-JVM, Maven and Selenium.</p>
<p>In this tutorial, the <a href="https://github.com/vaadin/addressbook" target="_blank">Vaadin Addressbook tutorial</a> application is used as test target for which the tests are implemented.</p>
<p><!--more--></p>
<h1>TLDR: Give me the ready solution</h1>
<p>The test code implemented in this tutorial, with a clone of Vaadin Addressbook application, is available from my <a href="https://github.com/juperala/addressbook" target="_blank">GitHub account</a>. If you want to jump right into running tests, you can clone the ready solution and execute tests using maven:</p>
<pre class="lang:sh decode:true">git clone https://github.com/juperala/addressbook.git
cd addressbook
mvn verify</pre>
<h1>Step 0: Clone the application and add dependencies</h1>
<p>To get started in this tutorial, we need to clone the test target code from GitHub:</p>
<pre class="lang:sh decode:true">git clone https://github.com/vaadin/addressbook.git
cd addressbook</pre>
<h3>Run the application</h3>
<p>To get familiar with the Addressbook application, you can start-up the application with maven:</p>
<pre class="lang:sh decode:true">mvn jetty:run</pre>
<p>When started, the application can be accessed via browser in http://localhost:8080/</p>
<p><a href="http://jperala.fi/wp-content/uploads/2015/07/addressbook.png"><img class="alignnone size-medium wp-image-77" src="{{ site.baseurl }}/assets/addressbook-300x139.png" alt="addressbook" width="300" height="139" /></a></p>
<h3>Add test dependencies</h3>
<p>To begin our test development, we need to add needed JUnit, Cucumber and Selenium libraries in the project /<em><strong>pom.xml</strong></em> file as dependencies. Add following dependencies:</p>
<pre class="lang:default decode:true ">    &lt;dependencies&gt;
        ...
        &lt;dependency&gt;
            &lt;groupId&gt;junit&lt;/groupId&gt;
            &lt;artifactId&gt;junit&lt;/artifactId&gt;
            &lt;version&gt;4.12&lt;/version&gt;
            &lt;scope&gt;test&lt;/scope&gt;
        &lt;/dependency&gt;
        &lt;dependency&gt;
            &lt;groupId&gt;info.cukes&lt;/groupId&gt;
            &lt;artifactId&gt;cucumber-java&lt;/artifactId&gt;
            &lt;version&gt;1.2.2&lt;/version&gt;
            &lt;scope&gt;test&lt;/scope&gt;
        &lt;/dependency&gt;
        &lt;dependency&gt;
            &lt;groupId&gt;info.cukes&lt;/groupId&gt;
            &lt;artifactId&gt;cucumber-junit&lt;/artifactId&gt;
            &lt;version&gt;1.2.2&lt;/version&gt;
            &lt;scope&gt;test&lt;/scope&gt;
        &lt;/dependency&gt;
        &lt;dependency&gt;
            &lt;groupId&gt;org.seleniumhq.selenium&lt;/groupId&gt;
            &lt;artifactId&gt;selenium-java&lt;/artifactId&gt;
            &lt;version&gt;2.45.0&lt;/version&gt;
            &lt;scope&gt;test&lt;/scope&gt;
            &lt;type&gt;jar&lt;/type&gt;
        &lt;/dependency&gt;
        &lt;dependency&gt;
            &lt;groupId&gt;org.seleniumhq.selenium&lt;/groupId&gt;
            &lt;artifactId&gt;selenium-firefox-driver&lt;/artifactId&gt;
            &lt;version&gt;2.45.0&lt;/version&gt;
            &lt;scope&gt;test&lt;/scope&gt;
            &lt;type&gt;jar&lt;/type&gt;
        &lt;/dependency&gt;
    &lt;/dependencies&gt;</pre>
<p>&nbsp;</p>
<h1>Step 1: Write Cucumber acceptance tests</h1>
<p>First, we need to define the tests for Cucumber. Cucumber uses Gherkin DSL (Domain Specific Language) parser to parse domain-specific plain text test specification. The plain text test specification follow the BDD-style <em>"Given...When...Then..."</em> pattern to define pre-conditions, system behavior and expected post-condititons.</p>
<p>After familiarization with the Addressbook application, we identified three main features of the Addressbook application:</p>
<ul>
<li>Adding persons to contact list,</li>
<li>Searching persons from contact list, and</li>
<li>Updating persons in the contact list.</li>
</ul>
<p>Next we create Cucumber test specification for these features. In Cucumber-JVM the test specifications for features are stored by default in <strong><em>/src/test/resources/&lt;package&gt;/&lt;feature-name&gt;.feature</em></strong> directory.</p>
<p>Define add feature in file: <strong><em>/src/test/resources/feature/contact/add/add.feature</em></strong>:</p>
<pre class="lang:sh decode:true">Feature: Add person to contacts
    Addressbook must be able to support adding persons in contact list.

    Scenario: Add new person
        Given the system is initialized
        When new person with firstname 'Teppo' and lastname 'Testaaja' is added
        Then person with firstname 'Teppo' and lastname 'Testaaja' exist in contacts

    Scenario: Cancel addition
        Given the system is initialized
        When adding new person with firstname 'Lasse' and lastname 'Laaka' is started but operation is canceled
        Then person with firstname 'Lasse' and lastname 'Laaka' does not exist in contacts</pre>
<p>Define search feature in file: <strong><em>/src/test/resources/feature/contact/search/search.feature</em></strong>:</p>
<pre class="lang:sh decode:true">Feature: Search person in contacts
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
        Then number of contacts is 2</pre>
<p>Define update feature in file: <strong><em>/src/test/resources/feature/contact/update/update.feature</em></strong>:</p>
<pre class="lang:sh decode:true ">Feature: Update person in contacts
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
          And person with firstname 'Keijo' and lastname 'Kekkonen-Patela' does not exist in contacts</pre>
<h1> Step 2: Implement Java tests for defined features</h1>
<p>After defining the scenarios, we need to create corresponding test classes in Java. In this tutorial we are using Cucumber JUnit runner to execute tests using JUnit test framework and we need to define the corresponding test classes for the add, search and update features:</p>
<p>Create add feature test: <strong><em>/src/test/java/feature/contact/add/AddContactIT.java</em></strong>:</p>
<pre class="lang:java decode:true">package feature.contact.add;

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
}</pre>
<p>Create search feature test: <strong><em>/src/test/java/feature/contact/search/SearchContactIT.java</em></strong>:</p>
<pre class="lang:java decode:true">package feature.contact.search;

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
}</pre>
<p>Create update feature test: <strong><em>/src/test/java/feature/contact/update/UpdateContactIT.java</em></strong>:</p>
<pre class="lang:java decode:true">package feature.contact.update;

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
}</pre>
<h1>Step 3: Implement Selenium mapping to Addressbook</h1>
<p>Next we need to create support for controlling the Addressbook target application using Selenium. In this tutorial we used PageObject pattern to separate the Selenium functionality into a separate page object class.</p>
<p>Create Addressbook page object: <strong><em>/src/test/java/pages/AddressBookPage.java</em></strong>:</p>
<pre class="lang:java decode:true ">package pages;

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

    @FindBy(css = "div.v-slot:nth-child(3) &gt; div:nth-child(1)")
    private WebElement cancelButton;

    @FindBy(css = ".v-horizontallayout &gt; div &gt; div &gt; .v-textfield")
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

    @FindBy(css = ".v-grid-tablewrapper &gt; table &gt; tbody &gt; tr:first-child &gt; td:nth-child(1)")
    private WebElement firstContactFirstName;

    @FindBy(css = ".v-grid-tablewrapper &gt; table &gt; tbody &gt; tr:first-child &gt; td:nth-child(2)")
    private WebElement firstContactLastName;

    @FindBy(css = ".v-grid-tablewrapper &gt; table &gt; thead &gt; tr:first-child &gt; th:first-child")
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
        List&lt;WebElement&gt; contacts = driver.findElements(By.cssSelector(".v-grid-tablewrapper &gt; table &gt; tbody &gt; tr"));
        Iterator&lt;WebElement&gt; iter = contacts.iterator();

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
        return driver.findElements(By.cssSelector(".v-grid-tablewrapper &gt; table &gt; tbody &gt; tr")).size();
    }
}
</pre>
<p>&nbsp;</p>
<h1>Step 4: Map Cucumber test steps to page object</h1>
<p>After creating the test classes and Selenium page object, we need to implement Cucumber test steps and map these to the created Selenium page object. For clarify and reuse, we define the steps in separate <em><strong>steps</strong></em> package. As seen in the Step 2, we used <em><strong>@CucumberOptions</strong></em> annotation and <em><strong>glue</strong></em> attribute to define the location where Cucumber tries to find corresponding step definitions.</p>
<p>Create Java step definition file: <strong><em>/src/test/java/steps/ContactSteps.java</em></strong>:</p>
<pre class="lang:java decode:true  ">package steps;

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
}</pre>
<h1>Step 5: Configure execution of tests in Maven</h1>
<p>To execute tests, we need to configure the execution of tests in project <em><strong>/pom.xml</strong></em> file. We defined the tests as integration tests (<strong><em>*IT.java</em></strong>) and use the <em><strong><a href="https://maven.apache.org/surefire/maven-failsafe-plugin/" target="_blank">maven-failsafe-plugin</a></strong></em> to execute these tests as part of the maven integration-test lifecycle. In addition, <a href="http://www.eclipse.org/jetty/documentation/current/jetty-maven-plugin.html" target="_blank"><em><strong>jetty-maven-plugin</strong></em></a> is reconfigured to start the test target in maven pre-integration-test lifecycle, and stop it in post-integration-test lifecycle.</p>
<p>Update <em><strong>/pom.xml</strong></em> with following build plugins:</p>
<pre class="lang:default decode:true ">&lt;build&gt;
        &lt;plugins&gt;
            ...
            &lt;plugin&gt;
                &lt;groupId&gt;org.eclipse.jetty&lt;/groupId&gt;
                &lt;artifactId&gt;jetty-maven-plugin&lt;/artifactId&gt;
                &lt;version&gt;9.2.3.v20140905&lt;/version&gt;
                &lt;configuration&gt;
                    &lt;scanIntervalSeconds&gt;10&lt;/scanIntervalSeconds&gt;
                    &lt;stopPort&gt;8005&lt;/stopPort&gt;
                    &lt;stopKey&gt;STOP&lt;/stopKey&gt;
                &lt;/configuration&gt;
                &lt;executions&gt;
                    &lt;execution&gt;
                        &lt;id&gt;start-jetty&lt;/id&gt;
                        &lt;phase&gt;pre-integration-test&lt;/phase&gt;
                        &lt;goals&gt;
                            &lt;goal&gt;start&lt;/goal&gt;
                        &lt;/goals&gt;
                        &lt;configuration&gt;
                            &lt;scanIntervalSeconds&gt;0&lt;/scanIntervalSeconds&gt;
                            &lt;daemon&gt;true&lt;/daemon&gt;
                        &lt;/configuration&gt;
                    &lt;/execution&gt;
                    &lt;execution&gt;
                        &lt;id&gt;stop-jetty&lt;/id&gt;
                        &lt;phase&gt;post-integration-test&lt;/phase&gt;
                        &lt;goals&gt;
                            &lt;goal&gt;stop&lt;/goal&gt;
                        &lt;/goals&gt;
                    &lt;/execution&gt;
                &lt;/executions&gt;
            &lt;/plugin&gt;
            &lt;plugin&gt;
                &lt;groupId&gt;org.apache.maven.plugins&lt;/groupId&gt;
                &lt;artifactId&gt;maven-failsafe-plugin&lt;/artifactId&gt;
                &lt;version&gt;2.18.1&lt;/version&gt;
                &lt;executions&gt;
                    &lt;execution&gt;
                        &lt;goals&gt;
                            &lt;goal&gt;integration-test&lt;/goal&gt;
                            &lt;goal&gt;verify&lt;/goal&gt;
                        &lt;/goals&gt;
                    &lt;/execution&gt;
                &lt;/executions&gt;
            &lt;/plugin&gt;
        &lt;/plugins&gt;
    &lt;/build&gt;</pre>
<h1> Step 6: All done, Enjoy!</h1>
<p>Now we have a working Cucumber-JVM example using JUnit, Maven and Selenium. Execute tests via maven:</p>
<pre class="lang:sh decode:true">mvn verify</pre>
<p>and observe the results:</p>
<p><a href="http://jperala.fi/wp-content/uploads/2015/07/build_success.png"><img class="alignnone size-medium wp-image-82" src="{{ site.baseurl }}/assets/build_success-300x114.png" alt="build_success" width="300" height="114" /></a></p>
<p>The html formatted Cucumber test reports can be found from the <em><strong>/target/results/*</strong></em> folder as defined in <em><strong>@CucumberOptions</strong></em> in Step 2.</p>
<p>Enjoy!</p>
