---
layout: post
title: Half dozen of hosted CI platforms
date: 2016-06-11 10:23:00.000000000 +02:00
background: '/img/posts/03.jpg'
comments: true
---

Continuous integration (CI) and Continous Delivery (CD) pipeline is one of the key enablers for agile development, release and continuous quality assurance. Traditionally CI platforms, like [Jenkins](https://jenkins.io/), [Teamcity](https://www.jetbrains.com/teamcity/) and [Atlassian Bamboo](https://www.atlassian.com/software/bamboo), have been self-hosted server applications deployed in in-house infrastructures.

During the last years dozens of SaaS-based hosted CI platforms have emerged. Having hosted CI environments reduces the need for environment maintenance and enables easy scaling of build and test resources with cost-effective pricing plans. Although many large enterprises still prefer to host their own CI infrastructures, often due security and legacy reasons, the hosted CI platforms provide good alternative for various needs from personal and open source projects to business and enterprise customers.    

Another change in the CI domain is change towards automated infrastructure and build configuration. In traditional CI environments build pipelines were configured manually via user interface, whereas the latest platforms support [Infrastructure as Code](https://en.wikipedia.org/wiki/Infrastructure_as_Code) paradigm by allowing configuration of build pipelines via configuration files committed in the project repositories. In addition, most platforms support RESTfull APIs and web hooks enabling integration of CI platforms with 3rd party services for configuration and monitoring of the build executions.

As a long-time user of Jenkins and Bamboo CI tools I wanted to catch up with latest hosted alternatives and their pricing and capabilities. To get an overview of the setup process and capabilities, I configured example Java/Maven project with Selenium browser tests for execution. In this post you find a short overview of reviewed tools and initial observations made during the project setup and configuration.

TravisCI
--------

TravisCI is probably the most popular of the hosted CI platforms - especially in Open Source community with over 300k projects relying on it. It supports building for both Linux and OSX environments. The big limitation of TravisCI is integration only with GitHub repositories.

The TravisCI setup for basic Java builds with browser testing is straightforward. Login to TravisCI with GitHub account, select repository to follow, push  *.travis.yml* configuration into repository and TravisCI will pick the changes and trigger builds automatically. TravisCI environment has Firefox preinstalled and only Xvfb virtual frame buffer needs to be configured for using Firefox. The example *.travis.yml* file is presented below:

{% highlight yaml %}
language: java
jdk: oraclejdk8
before_script:
  - "export DISPLAY=:99.0"
  - "sh -e /etc/init.d/xvfb start"
  - sleep 3 # give xvfb some time to start
script: mvn clean verify
{% endhighlight %}

Being free for Open Source project the TravisCI is very compelling alternative for public repositories, but for personal use the $129/month Startup plan feels overpriced and cheaper personal price plan would be welcomed.

+ **Homepage:** [https://travis-ci.com](https://travis-ci.com)
+ **Platforms**: Linux, OS X
+ **VCS support:** GitHub
+ **Pipeline configuration:** YAML
+ **Pricing:**
  + Free for Open Source (unlimited build minutes and repositories)
  + Starting at $129/month for private projects (2 concurrent jobs, unlimited build minutes and repositories)
  + Free trial (first 100 private builds free)
  + Student plan (100 free builds per month)
+ **On-Site deployment:** Yes. TravisCI Enterprise.
+ **Maturity:**
  + Founded 2011
  + Over 235k user accounts
  + Over 300k open source projects
  + References: Facebook, Heroku, Mozilla, Twitter,...
+ **API:** REST
+ **Browser testing:** Firefox, PhantomJS
+ **Other:**
  + iOS and Android (Beta) SDKs

CircleCI
--------

CircleCI is also one of the well-established hosted CI platforms. Similarly with TravisCI the CircleCI supports only GitHub repositories. The pricing plans differ from TravisCI as CircleCI offers each user first Linux container free of charge (1500 build minutes / month).

The usage of CircleCI is very similar with TravisCI. Login with GitHub account, select repository, add *circle.yml* configuration, and CircleCI will pick up the changes and trigger builds automatically. The only configuration needed was selection of correct JDK version and no additional configuration were needed for running Selenium tests with Firefox. The example *circle.yml* configuration is presented below:

{% highlight yaml %}
machine:
  java:
    version: oraclejdk8
{% endhighlight %}

With initial free Linux container the CircleCI provides great choice for personal use and can be scaled up for professional and business use.

+ **Homepage:** [https://circleci.com](https://circleci.com/)
+ **Platforms**: Linux, OS X
+ **VCS support:** GitHub
+ **Pipeline configuration:** YAML
+ **On-site deployment:** Yes. CircleCI Enterprise.
+ **Pricing:**
  + First Linux container free (unlimited repos and users, 1500 build minutes/month)
  + Additional containers $50/each, OSX plans starting from $39/month.
  + Four free Linux containers for Open Source projects.
+ **Maturity:**
  + Founded 2011
  + Over 90k user accounts
  + References: Facebook, Spotify, Docker, GoPro,...
+ **API:** REST
+ **Browser:** Firefox, Chrome, PhantomJS
+ **Other:**
  + SSH access for debugging builds.
  + iOS and Android SDKs

SnapCI:
-------

SnapCI differs from TravisCI and CircleCI as it does not support use of configuration files and build configurations are carried out via interactive user interface. The SnapCI divides build pipeline into consequent stages and each stage is executed in fresh build machine. Also SnapCI supports only GitHub repositories.

Configuration of SnapCI was very easy. After logging in with GitHub account and selecting the repository, the SnapCI preconfigured the build correctly for execution based on the project Maven POM configuration. The SnapCI is good alternative for people looking hosted CI platform with manually managed build configurations.

+ **Homepage:** [https://snap-ci.com/](https://snap-ci.com/)
+ **Platforms**: Linux
+ **VCS support:** GitHub
+ **Pipeline configuration:** No
+ **Pricing:**
  + Free for Open Source (1 parallel build)
  + Starting at $30/month for private projects (5 private repositories, 1 concurrent build)
+ **On-Site:** No. Only hosting plans.
+ **Maturity:**
  + Founded 2013
  + References: Mercedes Benz, Applauze, Neo4J, Sky,...
+ **API:** REST
+ **Browser testing:** Firefox, Chrome, PhantomJs
+ **Other:**
  + Android SDKs

Shippable:
----------

In contrast to previous platforms, Shippable supports both GitHub and BitBucket repositories. The initial plan for first pipeline is free, and additional pipelines can be added with cost-effective pricing.

Shippable claims to supports TravisCI compliant configurations (either named as *.travis.yml* or *shippable.yml*), but build failed when using earlier defined configurations for TravisCI. Shippable requires additional definition of Firefox addon for getting the Firefox installed in the container. In addition alternative configuration for setting up the Xvfb frame buffer was required to get build successfully compiled.

Personally I experienced the Shippable user interface to be less intuitive when compared to previously reviewed tools. As a GitHub user I did prefer earlier reviewed tools over Shippable. However, for BitBucket users the Shippable may be a competitive alternative. Also the pricing plans are quite competitive.

+ **Homepage:** [https://app.shippable.com](https://app.shippable.com)
+ **Platforms**: Linux
+ **VCS support:** GitHub, Bitbucket
+ **Pipeline configuration:** YAML
+ **Pricing:**
  + Free for first pipeline (1 build container, 1 pipeline)
  + Additional build containers $10/each
  + Additional pipelines $10 for 3 additional pipelines
+ **On-Site:** No
+ **Maturity:**
  + Founded 2013
  + Over 50k user accounts
  + References: SAP, Cisco, Postman,...
+ **API:** REST
+ **Browser:** Firefox, PhantomJS

Codeship:
---------

Similarly with Shippable, the Codeship provides support for both GitHub and BitBucket repositories. The Codeship builds are configured manually via user interface which is quite simple to use but not the most modern. For example, selection of repository is given by entering GitHub repository URL whereas previously reviewed tools provided full GitHub integration with capability of selection of repositories from a list view. The basic Codeship builds do not currently support YAML-based configurations, but this capability has been added to Docker-based containers (CodeJet).

For basic build the only configurations needed were selection of the JDK version using *jdk_switcher* command and definition of standard Maven goals. Firefox browser tests worked without any addition configurations. In general everything worked as expected, but the service would benefit from YAML based configurations.

+ **Homepage:** [https://app.shippable.com](https://app.shippable.com)
+ **Platforms**: Linux
+ **VCS support:** GitHub, Bitbucket
+ **Pipeline configuration:** No (Currently YAML support only for Docker-based CodeJet)
+ **Pricing:**
  + Free for 1 concurrent build and 1 parallel pipeline (1 build container, 100 builds, 5 projects, unlimited teams)
  + CodeJet with Docker containers starting from $75/month
+ **On-Site:** No
+ **Maturity:**
  + Founded 2011
  + Over 75k user accounts
  + References: Sears, CareerBuilder, BlastWorks,...
+ **API:** REST
+ **Browser testing:** Firefox, Chrome, PhantomJs, CasperJs, SlimerJs
+ **Other:**
  + SSH access for debugging builds.

SolanoCI:
---------

The advantage of SolanoCI is it's wide support for different repositories and version control systems. Whereas all previously reviewed CI tools were limited to GitHub and/or Bitbucket repositories, SolanoCI provides GitHub, GitLab, BitBucket, Stash, Git and Mercurial support.

The build configurations for SolanoCI are made using *solano.yml* configuration file and configuration was easy to setup. The user interface was not the easiest to use and there seemed to be minor bugs related to accessing build logs. The example *solano.yml* configuration is show below:

{% highlight yaml %}
java:
  java_version: java-8-oracle
  maven_version: '3.2.3'
firefox: '27.0.1'
tests:
  - mvn clean verify
{% endhighlight %}

---------
+ **Homepage:** [https://www.solanolabs.com](https://www.solanolabs.com)
+ **VCS support:** Git, GitHub, BitBucket, Stash, GitLab, Mercurial
+ **Pipeline configuration:** YAML
+ **Pricing:**
  + Starting at $15/month (2 workers, 10 worker hours)
  + 14-day free trial available
+ **On-Site deployment:** Yes. Solano Private CI
+ **Maturity:**
  + Founded 2011
  + Customer references: AirBnB, New Relic,...
+ **API:** REST
+ **Browser testing support:** Firefox, Chrome
+ **Other:**
  + SSH Debug Console (in Private release)
  + Docker container support
  + Android SDK

And the long list of alternatives
=================================

I limited my review to these six hosted CI platforms, but there is still at least dozen other popular alternatives providing similar features and capabilities, such as:

+ **[Drone.io](https://drone.io)**
  + YAML configuration
  + GitHub and BitBucket repositories
+ **[AppVeyor](https://www.appveyor.com)**
  + Continuous delivery for Windows applications
  + YAML configuration
  + GitHub, BitBucket, Visual Studio Online, GitLab, Kiln, Subversion, Git, Mercurial and  Stash repositories
+ **[Wercker](http://wercker.com)**
  + YAML configuration
  + Container-centric platform for automation
+ **[HostedCI](https://hosted-ci.com/)**
  + Jenkins based hosted CI for iOS and OS X projects
  + Full Git, Mercurial and SVN repository support
+ **[SemaphoreCI](https://semaphoreci.com)**
  + YAML configuration
  + Docker optimized CI platform
+ **[Bitrise](https://www.bitrise.io/)**
  + CI for mobile platforms (iOS, Android, Xamarin)
  + YAML configuration
  + Run locally with CLI

Summary
=======

Nowadays there is available dozens of alternative hosted CI platforms. Most of there are capable of providing support for complex build pipeline configurations, parallelization and integrations support with 3rd party services. As the pricing and features vary, the selection of the platform should be made based on the requirements set for the project.

Based on this short review, I personally liked usability of the TravisCI and CircleCI. Both of these provided very similar approach for configuring and managing build pipelines using YAML configuration files. In addition, the SnapCI provided very clean and intuitive user interface to configure builds via web-based user interface.
