---
layout: post
title: Getting started on Web Development
description: Getting started on Web Development. My first fullstack project with JavaScript, React and AWS cloud. What I did and learned?
date: 2018-01-26 22:43 +02:00
last_modified_at: 2020-03-26 17:13 +0200
author: jperala
published: true 
header-img: "img/post-bg-01.jpg"
image: "img/post-bg-01.jpg"
comments: true
---
It kind of shocked me to realize that I've never really developed frontend web applications - There just haven't been any need for it. For the most of my career I've worked on job roles related to test automation. That includes plenty of programming and development on daily basis, but all the development I do is for testing. Meaning things like writing automated tests using frameworks such Selenium, JUnit and Robot Framework; creating automation scripts for setting up test environments; developing test tools; and so on. I've also worked purely on development roles, but always related to embedded or backend development.

Inspired by this "revelation" I decided to start an side-project to get more familiar on developing frontend applications with modern tools. It would give me also a great opportunity to try out cloud platforms and their benefits from app development perspective - for now I've used cloud platforms only for testing related tasks.

Here's story of what I did and thoughs throughout the learning path. The post does not aim to be a step-by-step tutorial, but rather give an overview of what to look into when starting frontend web development.

## The Goal
I wanted to develop some application that could potentially be somewhat usefull for others also. Maybe something that uses Open Data.

Few years ago a massive undeground parking station (Kivisydän) was opened in Oulu and I've always been kind of curious does it ever get fully crowded. As it happens to be, the City of Oulu exposes the realtime utilization of parking stations as [Open Data](https://data.ouka.fi) API, so I decided to write an application that would store this information and show the parking stations current utilization and statistics in a web application.

As I wanted to store the utilization information for statistics, It was clear that I would need to implement the frontend application that shows this information, and also backend functionality that fetches data from public API, stores it database and provides API for the frontend application to query stored data. 

## What tools for development?
Getting started on web development can be a bit painful. Even though I have plenty background with other programming and as a tester I've worked a lot with web apps to know solid basics of HTML markups and CSS styling, it wasn't fully clear what tools and libraries I need to get started. As a new to frontend development it kind of felt that there is countless number of .js libraries and tools for everything and I felt bit unsure to know what tools would I need and what tools overlap with others.

One great resource describing the tools and frameworks in web development that I found was Matt Raible's Devoxx talk ["Front Ends for Back End Developers"](https://www.youtube.com/watch?v=AjzyV8BraIs). That is definitely worth watching.

After a bit of googling and familiarization, it started to look that the things I would probably need to choose or atleast be aware of are:
+ Programming language
+ Application Framework
+ Dependency management tool
+ Build tool
+ Test tool
+ Bundler
+ Transpiler

### Programming language
With programming languages you have few options, whether to use plain JavaScript or some alternate language like [TypeScript](https://www.typescriptlang.org/) that compiles into JavaScript. With Java background I am more used to languages with static types so TypeScript sounded like an great way to go. However, to start with the basics I decided to use plain JavaScript, after that it would be straighforward to use other JavaScript-compilable languages also.

What comes to JavaScript, it's also good to be aware of alternate versions supported. The ES5 is the "old-school" JavaScript supported by pretty much every browser. The ES6 (ES2015) changed the syntax quite a bit and introduced entities like classes to JavaScript. Also ES6 is nowadays well covered, but features introduced in ES2016 and beyond may not work on all browsers and environments (see [compatibility table](http://kangax.github.io/compat-table/)). The good thing is, that even the newer features can be used with transpilers (e.g. Babel) that rewrite the code to be compatible with older JavaScript versions.

Besides JavaScript and TypeScript, there is also other languages to look into such [ELM](http://elm-lang.org/), [PureScript](http://www.purescript.org/), [ClojureScript](https://clojurescript.org/), [CoffeeScript](http://coffeescript.org/), and so on. Be open-minded and try what fits you the best.

### Application Framework
You can develop applications with plain (vanilla) JavaScript, but most projects use some kind of web framework for project structure. The top-3 currently seems to be [React](https://reactjs.org/), [Angular](https://angular.io/) and [Vue.js](https://vuejs.org/). For any of these you are likely to find good community support with examples, forums, etc. There is also endless amount of other frameworks, [Meteor](https://www.meteor.com/), [Ember.js](https://www.emberjs.com/) and [Cycle.js](https://cycle.js.org/) to mention few.

For my project I chose React due it's wide popularity and having colleagues with experience on it.

### Dependency & Build Tools
When developing your application you need to somehow manage and download the needed dependencies and tools. For this you most likely end-up using [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/en/). Npm is the good 'ol package manager that most tutorials seems to be using. Yarn is newer tool aiming to solve some problems and performance issues npm has.

Both npm and yarn can be also as build tools by running project-specific scripts with run command. In addition there is dedicated task runner tools like [Gulp](https://gulpjs.com/) and [Grunt](https://gruntjs.com/) to carry out more complex build tasks.

In my project I ended using npm but will move to yarn for future versions.

### Test tools
For testing your application there is an variety of JavaScript based test tools available that integrate into your build configuration. Some potential testing tools to checkout:
- [Jest](https://facebook.github.io/jest/) - default test with React's [create-react-app](https://github.com/facebook/create-react-app). Works with any JavaScript code.
- [Protractor](http://www.protractortest.org/) - End-to-end testing framework for Angular applications.
- [Jasmine](https://jasmine.github.io/) - Behaviour driven development framework for testing JavaScript. Works with any JavaScript code.
- [Cypress.io](https://www.cypress.io/) -  Complete end-to-end testing for anything running in browser.
- [Nightwatch.io](http://nightwatchjs.org/) - Browser automated testing done easy.

For testing there is no reason to limit only on JavaScript based test tools, but use any tool you find suitable. For example [Postman](https://www.getpostman.com/) is a great tool testing APIs, no matter what the implementation language is.

I used Jest that came preconfigured with React's create-react-app and also Postman for API testing.

### Bundler
When you want to run your application in a browser, you need to deliver all the dependent code modules to be able to execute your code. In very small projects with minimal dependencies you could just include your scripts as is, but for anything bigger you want to bundle up your code (and resources) to minimize the http requests and size of file downloads. For this there is tools such [Webpack](https://webpack.github.io/) and [Browserify](http://browserify.org/).

I used Webpack that came preconfigured with React's create-react-app.

### Transpiler
When using the latest features not yet supported by all targeted browsers, you may need to transpile the code to be compatible with older JavaScript versions.

[Babel](https://babeljs.io/) is the de-facto tool to do it.

## What Tools for Cloud Deployment?
Once it was clear what tools to use for developing the frontend app, I needed to think about deployment. I didn't want to setup my own server, or virtual server that would require maintenance and create continuous costs for hosting the application.

This in mind I wanted to use cloud platform such [Amazon AWS](https://aws.amazon.com/), [Microsoft Azure](https://azure.microsoft.com/) or [Google Cloud Platform](https://cloud.google.com/). For the backend application I also wanted to use serverless infrastructures that would enable deployment of the API as cloud functions billed by usage.

All big three cloud platforms provide quite comparable features and pricing, but for now I chose to use Amazon AWS. To deploy and host the application I used the AWS services described below.

### Hosting Static Content
The created React application is client-side application that access dynamic content via API. For the static files of the React application I used [AWS S3](https://aws.amazon.com/s3/) bucket to store files. You can either use S3 directly to host your website, or AWS Cloudfront CDN to deliver the content from S3 bucket.

### Domain & DNS & HTTPS
I wanted to deploy my application in own domain oulunparkit.com. In AWS you can use [AWS Route 53](https://aws.amazon.com/route53/) service to buy domain and setup hosted zone for DNS routing. To add support for SSL/TLS security for HTTPS, there is [AWS Certificate Manager](https://aws.amazon.com/certificate-manager/) to create custom certificate. 

### Content Distribution
To speed up delivering content from S3 storage you can use [AWS Cloudfront](https://aws.amazon.com/cloudfront/) CDN network to distribute and cache content from multiple edge locations. In case you are using custom domain and want to enable HTTPS access to content served from S3 storage, you need to create CloudFront distribution to handle custom certificate. 

### API Functions & Deployment
To create API for data queries you need a place to deploy your API functions. [AWS Lambda](https://aws.amazon.com/lambda/) provides serverless function service to execute functions written in Node.js, Java, .NET, Python or Go. To expose the Lambda function as external API you can use the  [AWS API Gateway](https://aws.amazon.com/api-gateway/).

### Database
For the API data storage we need a database. In AWS you have options such [AWS DynamoDB](https://aws.amazon.com/dynamodb/), [AWS RDS](https://aws.amazon.com/rds/) and [AWS Aurora](https://aws.amazon.com/rds/aurora/). Depending whether you need transactional or no-sql database and type of features and pricing any of these would be an option.

In my application I decided to use AWS DynamoDB as database.

### AWS CLI
Configuring and deploying AWS services can be done via AWS Management Console web app. However, for development using it becomes easily cumbersome, so taking the AWS CLI into use is definitely worth looking into. It enables you to easily create, modify and deploy AWS services and instances via command-line interface.

## Developing the Application
After it was clear what development tools and cloud services to use it was time to sink into tutorials to recap JavaScript language features and dive into React. Starting development with React was surprisingly straigthforward with the [Tic-Tac-Toe tutorial](https://reactjs.org/tutorial/tutorial.html) and using the the create-react-app tool that creates a ready project skeleton with Babel, Webpack, Jest and other tools preconfigured.

The great thing with React is also a vast amount of ready made components to use in your application. For example, to create graphs I used [ReCharts](http://recharts.org/), for drawing Google Map there is [google-react-map](https://github.com/istarkov/google-map-react) and for tabs there was [react-tabs](https://github.com/reactjs/react-tabs). I also added localization support (FI and EN) using the [react-localization](https://github.com/stefalda/react-localization).

One thing to think about is the styling of the components. You can write your own components with custom CSS, but there is also many responsive UI frameworks such [Material-UI](http://www.material-ui.com/), [Semantic-UI](http://react.semantic-ui.com/) and [React-Bootstrap](https://react-bootstrap.github.io/).

Developing the API functions for AWS Lambda was also very straighforward. AWS provides ready-made blueprints configuring the lambda for use as microservice backed with DynamoDB.

## The Result: oulunparkit.com
Well, it's still lacks some features and UI finishing, but the first versions of the app is released in [oulunparkit.com](https://oulunparkit.com/).

In the application you can see the current utilization of parking stations either in map or list view. By selecting an   parking station you can dive into station details and see the utilization statistics for the last 1, 7 or 30 days as a graph. 

The plan is to update the app to allow users to input free-range statistics period to be shown. Currently the app uses tiny responsive CSS framework called [lit](https://ajusa.github.io/lit/), but the plan is to dabble with Material-UI and alternative UI frameworks to improve the UI look & feel. I also intend to rewrite the app behaviour to play around with React-redux and React-router modules. 

The sources are available in my GitHub repository [parking-oulu](https://github.com/juperala/parking-oulu).

## Wrap-up
In overall developing and deploying a full application was a very learning experience. There wasn't any major obstacles on the development, only new tools to learn about. For any problem there was great amount of resources available with a bit of googling.

Definitely the biggest challenge was to start and get high-level understanding of what tools to be used for what task. After you known what you need to accomplish, for any of the used tools used there was plenty of materials available to dive into details and find the solution. And when unsure what tool does or how it works, just go through the tutorials.

It was also nice to find out that working in test automation development doesn't differ so much from application development. Sure, the languages, tools and libraries used were mostly new and it takes time to master them deeply. But after all it's just about understanding what tools/libraries to use for what purpose and how to use them together.