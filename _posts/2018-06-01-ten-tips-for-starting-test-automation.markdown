---
layout: post
title: Ten Tips for Starting Test Automation
description: This is my list of ten tips for getting started and keeping your test automation projects on the right track and avoid common culprits and challenges.
date: 2018-06-01 00:01 +03:00
last_modified_at: 2020-03-26 17:14 +0200
author: jperala
published: true 
header-img: "img/home-bg.jpg"
image: "img/home-bg.jpg"
comments: true
---
_This is a re-post from an original two-post article posted in [Bitfactor Blog](https://bitfactor.fi)_

***

**_Lost in test automation? Here is my selection of 10 tips for getting started and keeping your automation projects on the right track._**

In modern software development the need of test automation is evident. Latest development trends such as Continuous Delivery and DevOps aim towards ability for fast and iterative software releases, and automation of the development and release pipeline from developer workstation all the way to the production deployment. All this sets major challenges for testing and QA practices needed to ensure product quality. When release cycles are shortened from months to weeks and days, testing every release by hand is no longer a viable option. Even the basic regression testing of unchanged functionality can easily exhaust available testers, thus risking the release schedules and overall product quality.

Luckily, getting started with test automation is easy. There are numerous automation tools and frameworks and plenty of material available on the internet to get started. With these even testers with no previous experience on test automation development can get their first tests up and running relatively quickly.

However, what starts as a small and easy automation project tends to grow and become more complicated. As time goes by, new tests will be added, the need to support various product variants and versions becomes evident, test environments and tools change, people leave and join the project, and bunch of other unforeseen changes will happen. Without planning and clear focus automation projects can easily get bloated and side-tracked leading to exhaustive maintenance burden that will eventually reduce the benefits gained from the automation.

This post will give ten pointers for getting started and keeping your automation projects on the right track. The list is not complete, but highlights common culprits and challenges observed in many automation projects.

# Automation is a tool for testing, not a replacement
The common misunderstanding across the IT industry is that all testing should be automated. In reality there is no 100% test automation – or at least it will not be cost-effective.

Automated tests are merely checks that ensure software works as it was expected. As such, automation is an excellent tool for checking that nothing was broken when new product features were added and that new features work according to the specification. However, in practice it doesn’t make sense to check every imaginable detail of the product as it would eventually make your test suite unmaintainable. Automation also provides very limited or no support when it comes to identifying unknowns and unspecified product behaviour.

Gaining understanding whether the developed features really fulfil your customer needs in given context and constraints still requires plenty of human thinking, communication, collaboration and exploration. Create automation that enables testers to focus on the essentials instead of doing repetitive tasks that are well suited for automation.

**_Exploratory testing paired up with smart automation strategy is a killer combination for bug hunting. Empower testers to focus on critical thinking and brainwork by letting automation take care of the repetitive tasks. Focus on automation that will bring most value to your team._**

# Your tests are a product
Many companies have well-defined processes and practices for developing quality software products, but may lack nearly all quality control when it comes down to developing and maintaining test assets. Test assets may be also developed and maintained by testers with limited software development and coding experience compared to full-time software developers.

Although tests are not typically delivered to your customers with product releases, the lifecycle of your tests can be as long as the lifecycle of your products. Tests written today may be used for years after product delivery to ensure future maintenance updates and releases.

To ensure your test assets are reliable, maintainable and easily extendable, good software development practices should be enforced. Also put focus on selecting right the automation tools and framework supporting your testing needs.

A few things to think about in test asset development:

* Version control, branching, tagging, linking tests to product versions.
* Uniform and consistent coding convention.
* Self-describing test code naming (classes, methods, variables, commits).
* Configurability vs. hard-coded values and magic numbers.
* Quality practices & learning: Code reviews, pair- and mob programming.

**_Writing test automation is software development – treat it as such. Focus on having good quality test assets that are easily maintainable and follow good development practices. Value of test suite is on providing information about the product. Having unreliable and ambiguous test suite creating misinformation can be worse than not having tests at all._**

# There is no “I” in automation
The value of any testing is on providing information about the product to stakeholders. That in mind, automation should never be only your personal quest.

Before starting out automation, get commitment from your team and organization. Define expected goals and scope for automation together, and include these in your team DoD (Definition of Done). Work together as a team, with support of both developers and testers, to achieve your goals.

Make sure the results of automated tests are always up-to-date and available to your team and other stakeholders so they have the latest information to support development decisions. Automate only tests that provide meaningful information; there’s no point in automating things that nobody cares about.

**_Getting best value out of automation requires commitment from the whole team and organization. Work together. Create tests that bring value and meaningful information to your stakeholders._**

# Solid base
Most testers starting to dabble with automation have their first experience usually with UI (GUI) automation tools. In web context, it’s commonly Selenium WebDriver or some test framework using Selenium under the hood. It makes perfect sense: as a tester you obviously want to test the whole application end-to-end, with all nuts and bolts installed. And Selenium is a great tool for that with plenty of resources and examples to get started.

Alas, eventually you learn UI tests can be one of the most problematic tests to automate. First of all, they can be problematic regarding the project schedule. Testing the product via UI means you’ll need a working UI. However, that is often subject to continuous changes, fine-tuning and may be finalized in the very end of the project. Sometimes even the smallest UI changes can break your automation scripts, requiring excessive maintenance and refactoring work to keep up with the latest UI design. Secondly, implementation of UI based end-to-end tests with whole system in place have a tendency of being slower to execute and more brittle as there are more moving parts. Setting up test environment and test development is also usually more costly as there are more parts to configure and manage.

Often teams put too much value on testing everything end-to-end in realistic environment with production UI. Aim to start automation as early as possible in the scope the functionality is implemented. Shift left. Have plenty of precise tests with detailed granularity, keep feedback loop fast from testing to development, and aim to develop tests that are robust to unrelated changes. Work your way up having relevant tests in each level, all the way from single units, to APIs, and finally to the UI layer. Usually this approach is described as a test pyramid, an idea initially coined by Mike Cohn and few others, where you should have solid base of unit and integration tests checking most of the things to be covered in testing.

The test pyramid concept is also somewhat controversial and subject of numerous discussions in the community. My personal opinion is to use it as guideline, but not to take it too strictly as rule that can’t be broken. It’s not automatically wrong for example to have more end-to-end tests than integration tests automated. Also the cost and effort needed for solid unit test coverage can surprise in context where exhaustive use of mocking is required – test execution speed does not reflect the test implementation speed. Aim for shift left, don’t limit only to testing in one level, and adapt your way of working to find right balance of tests in your domain and context.

**_Create solid base of unit and integration tests to catch most changes of the product, accompanied with smaller set of positive and negative end-to-end tests verifying overall functionality. Fill gaps with exploratory testing._**

# Don’t fall in love with your code
It’s not uncommon to see test assets filled with obsolete information such unused classes and methods, commented-out code lines, outdated configuration files and obsolete test cases.

Having obsolete code and test data makes the project hard to learn, follow and work with. Enforce good coding practices keeping the code base clean of obsolete and deprecated code that can become source for misinformation and technical debt. Create daily habit to cleanup obsolete test assets from repository.

**_Avoid technical debt and risk of misunderstanding. If test asset - whether it’s code, configuration, test, or anything else - becomes obsolete, thrash it. You have version control tools to keep track of the old versions in case you need to revert back to it._**

# As weak as your test data
To test deleting a bank account, you need to have a bank account created first. To test user login, you need a registered user information created. Practically all testing relies on the use of test data. How this data is created for testing purposes depends on the test scope and the context. In unit and integration tests, the test data may be generated using suitable mock interfaces and in-memory databases initialized at test setup, whereas a system-level test may rely on real database populated with SQL script, and so on.

Especially for end-to-end testing of complex systems it may not be always trivial to automate the creation of realistic test data, and you may be tempted to use manually created test data in your automated tests. Although using manually created test data may be an applicable solution in some cases, it has in general many limitations that may bite you back later. Manually created data may expire unless maintained periodically, you may not be able to edit or delete it if other tests rely on it, and running multiple tests utilizing same data can cause flakiness and unexpected behaviour. The worst case would be using shared test data, such as data used both by automation and exploratory testing, that may change its state uncontrollably.

Find ways to automate the creation of test data. Each test should rely on unique data that it may use, modify or delete on test execution. Ensure test data is always in a known state before test execution. Also remember to test the product with realistic data set sizes that are expected in production use.

**_Success of automation depends on the quality of test data. Avoid use of manually configured, shared or uncontrollable test data. Find ways to mock, populate or virtualize data sources in your test environment to be suitable for your testing needs._**

# Works on my computer
I bet everyone has heard someone retort “Works on my computer”? Too much time is wasted on investigation and fixing issues related to differences in various test environment configurations causing the software behave unexpectedly.

Most often these problems are a consequence of manual setup and configuration of test environments leading to configuration nuances between different environments. Manual configuration is time consuming, prone to human errors, non-reproducible, and lacks rollback support to previous configurations. As a result, what works on your environment may not work on your colleagues’ - seemingly similar - environment and vice versa.

Another challenge are unstable test environments that may fail randomly during test setup and execution. Unstable environments create misinformation in terms of false test results, eat up credibility of the testing, and analysing these errors take valuable time away from actual testing work. In worst case these environmental issues can kill the benefits otherwise gained from automation.

Find ways to automate the setup and management of test environments. Use configuration management and virtualization tools (e.g. Docker, Puppet, etc.) to create infrastructure-as-code configuration that can be used throughout the development pipeline to setup reproducible development and testing environments for different phases and needs.

**_Focus on creating a pipeline from developer workstation to production where environments work in similar manner. Avoid manual configurations and create automated scripts for creation, configuration and deployment of test environments with suitable tools._**

# Timing is everything
The world is asynchronous. Whether your tests are expecting response from native GUI, web application (browser), API or proprietary interface, the expected events will most likely be happening in an asynchronous manner. If your tests are not prepared for this, they may become flaky and fail unexpectedly due unknown response times of the application under test.

Typical example of this is Selenium WebDriver based browser tests that can be extremely flaky unless appropriate waiting of correct web element state is used. In case the test does not wait an element to become present and visible before trying to interact with it, the test may fail unexpectedly. Too often these types of issues are resolved by adding fixed delay (sleep) before interaction. Although a common practise, it is a bad approach making the test slow to execute with no guarantee of stability unless excessively long delays are used. Preferred solution in this context would be to set up an explicit wait that waits until the element is ready for interaction.

Regardless of used test tools and context, it is important to understand the implications that timing handling has to your tests, and how to mitigate them correctly to avoid test flakiness. Identify asynchronous events in test interactions and apply solutions to handle them without fixed delays.

**_In your tests, know what is expected to happen and wait for it. Don’t rely on fixed delays that will slow down test execution with no guarantee for stability._**

# Simplify, isolate the unknown
When developing automated tests, keep them as simple as possible. Keep tests short and avoid adding too much content in a single test (suite). Create test suites that focus on a specific feature of your product.

Create tests that are atomic and well focused. Atomic tests are order independent and not dependent on the execution or results of other tests. Use suitable setup and teardown functions to keep the product in known state to achieve atomicity. Each test should have only one focus that it tests. Failure of test should explicitly identify the problematic part in the product without excessive result analysis.

Tests should also be resilient to changes outside the test scope. Avoid using product features outside your defined test scope that may be subject to unexpected changes. As an example, if you are testing an embedded application that is part of a larger web portal, create tests that focus only on that specific app. When interacting with the application under test, create selectors that are resilient to changes that may happen in the portal page outside current test scope.

**_Keep your tests simple. Tests should tell directly what part of the product failed. Avoid vague shotgun tests without known scope. Create atomic tests that are resilient to changes happening outside the defined test scope to avoid test maintenance work and false negatives._**

# Don’t repeat yourself
When working with multiple projects, or even single project with multiple test cases, avoid writing duplicate test code. If the same test step or functionality is used in multiple test suites and projects, modularize the functionality as its own test library that can be imported and reused in other projects.

Creating reusable test modules and libraries brings multiple benefits. First, creating new projects will become easier as you will have a growing set of reusable functions available vs. always starting from the scratch. Second, it will ease the maintenance of the test assets when product functionality changes. When the functionality changes, the changes need to be done only in a single point in test code instead of refactoring all the related test projects and test cases.

As you start creating reusable test libraries for your product, don’t forget to document and communicate availability of those libraries within your teams and organization. Otherwise there is a risk of individual teams creating duplicate test libraries causing risk of confusion and extra maintenance effort.

**_Reuse, reuse, reuse. Develop test modules and libraries to unify the way your tests behave. Avoid duplicate code and the need to fix same issue in multiple places._**

# Final thoughts
Getting started with test automation can feel overwhelming. If you are a tester starting out automation without earlier programming experience, the learning curve can be especially steep while learning both coding and automation basics in parallel. But don’t stop. Keep going, learn and remember that no one is a master in the beginning.

The great news is that there are great resources and communities to support your journey in automation. When stuck or unsure about the best way to continue, seek help. Check out available documentations, tutorials and resources on the Internet, read a book, or ask a question in testing communities such Ministry of Testing or Testers.io.

Also check out available training and commercial offerings near you. There are many great services and companies with automation expertise to support, coach and ensure successful adoption of test automation in your organization.

**_Start, keep going and get connected. There are great communities, events, trainings & partners to support your automation challenge._**