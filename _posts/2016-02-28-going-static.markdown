---
layout: post
title: Going static - From WordPress to Jekyll
date: 2016-02-28 00:25:26.000000000 +02:00
author: jperala
"header-img": "img/post-bg-01.jpg"
published: true
comments: true
tags:
- Blog
- Jekyll
- Wordpress
---

I am a lazy blogger - I only write occasionally. Originally I setup my blog to get familiar with Content Management Systems (CMSs). For the last 2 years this blog has been hosted on cheap $5/month VPS server running WordPress. Although I write only few posts per year, maintaining the server requires some additional effort on monthly basis. The server and CMS needs to be kept up-to-date to avoid security risks, backups needs to be managed, and so on. Especially the security concerns have been topic during the last year as numerous security vulnerabilities have been identified in the WordPress. There is also the cost issue, although insignificant, caused by the maintenance of the VPS server hosting. So it is time to try something new.

The easiest alternative would have been to move the blog to any hosted blogging platform such *Wordpress.com* or *Blogger.com*. However, I am a tech guy by nature and like to know what happens under the hood of the system. Therefore I started looking alternative blogging platform that would require less maintenance than WordPress, but yet give full control over the system.

Static web-page generators like [Jekyll](http://jekyllrb.com/) and [Hugo](https://gohugo.io/) have gained huge popularity during last years. With static web-page generators you write your posts and content as plain text files with markup syntax, which is then compiled into static HTML website using the template files. Although the static sites are somewhat more limited than full-blown CMS systems, there is also notable benefits:

+ Simplicity.
  + No databases or server-side processing, only static files deployed on file-server.
  + No more database backups. Just keep your site source files in version control and you're backed up.
+ Security.
  + No more security risks caused by the CMS platform or plugin vulnerabilities.
  + No maintenance of CMS and plugins versions, users and roles.
+ Cost
  + Site can be deployed on low-cost file-server (e.g., [Amazon S3](https://aws.amazon.com/s3) or freely on [github.io](https://github.io)).
  + No need for VPS server or Amazon EC2 resources.

After going through the benefits, I decided to migrate my blog as static *Jekyll* website. Jekyll is used to power the GitHub pages, so the tool is well matured and has large user base. Also, the Jekyll site can be freely hosted on GitHub pages, so there is no longer need to maintain separate VPS for blog hosting.

### From Wordpress to Jekyll

Migrating from Wordpress to Jekyll was surprisingly straightforward.

### Install Jekyll

Installing Jekyll with gem (detailed instructions in [Jekyll](http://jekyllrb.com/)):

{% highlight sh %}
gem install jekyll
{% endhighlight %}

### Create new project template (or fork a Jekyll theme)

Create new jekyll site and deploy it locally:

{% highlight sh %}
jekyll new my-website
cd my-website
jekyll serve
{% endhighlight %}

Alternatively, clone a Jekyll theme you want to use, e.g.:

{% highlight sh %}
git clone https://github.com/BlackrockDigital/startbootstrap-clean-blog-jekyll.git my-website
cd my-website
jekyll serve
{% endhighlight %}

Once the jekyll is serving the site locally, the site can be previewed on http://localhost:4000.  

### Export existing posts from Wordpress to Jekyll

Go to WordPress site and export the site as *wordpress.xml* file. Once exported, run the jekyll-import that generates the posts into Jekyll project:

{% highlight sh %}
gem install jekyll-import
ruby -rubygems -e 'require "jekyll-import";
    JekyllImport::Importers::WordpressDotCom.run({
      "source" => "wordpress.xml",
      "no_fetch_images" => false,
      "assets_folder" => "assets"
    })'
{% endhighlight %}

*Note:* You may need to go through the generated posts in the *_posts/* folder to fix invalid links and image references to old Wordpress site.

### Deploy site

If you want to deploy the Jekyll site to free GitHub pages, commit the project to your github.com account. Just name the repository as *&lt;yourname&gt;.github.io* and the github automatically builds the site into the *http://&lt;yourname&gt;.github.io*.

Alternatively, if you want to deploy the site to another file-server, build the site locally and deploy generated static site from *_site/* folder to fileserver of your choice:

{% highlight sh %}
jekyll build
cd _site
{% endhighlight %}
