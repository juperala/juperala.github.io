---
layout: post
title: Adding comments to static site
date: 2016-06-26 21:55:12.000000000 +02:00
author: jperala
"header-img": "img/post-bg-03.jpg"
published: true
comments: true
tags:
- Blog
- Jekyll
- Disqus
- Comments
---

As I wrote [earlier]({% post_url 2016-02-28-going-static %}), I migrated my blog from Wordpress to static Jekyll website. I really like the static website as a concept as it makes the site maintenance less complicated and straightforward. However, being a static site, there is no native support for adding dynamic features such as post commenting.

Luckily, there is easy way to add commenting to static sites using external services such as [Disqus](https://disqus.com/).

Here's a step-by-step guide for adding Disqus commenting on Jekyll site.

Create Disqus account
=====================

Register to [Disqus](https://disqus.com/) and add your first website. Disqus will ask a shortname for your site and opens the site settings page. Enter site URL and name.

[![Disqus site configuration]({{ site.baseurl }}/img/2016-06-26/disqus-small.png)]({{ site.baseurl }}/img/2016-06-26/disqus.png)

Next go to Disqus installation page and copy *Universal Code* snippet to text editor.

{% highlight js %}
<div id="disqus_thread"></div>
<script>
    /**
     *  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
     *  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables
     */
    /*
    var disqus_config = function () {
        this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
        this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
    };
    */
    (function() {  // DON'T EDIT BELOW THIS LINE
        var d = document, s = d.createElement('script');
        s.src = '//SITE_SHORTNAME.disqus.com/embed.js';
        s.setAttribute('data-timestamp', +new Date());
        (d.head || d.body).appendChild(s);
    })();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus.</a></noscript>
{% endhighlight %}

All done on Disqus, next we need to edit Jekyll template to enable commenting.

Modify Jekyll post template
===========================

Open the appropriate post template from your Jekyll project. On the *Clean Blog* theme the post template file is */_layouts/post.html*. Add the copied *Universal Code* snipped inside *{% raw %}{% if page.comments %}{% endraw %}* and *{% raw %}{% endif %}{% endraw %}* liquid tags.

Uncomment the recommended configurations and update variables so that the correct information is picked up from Jekyll configuration:

{% highlight js %}
var disqus_config = function () {
  this.page.url = "{% raw %}{{ site.url }}{{ page.url }}{% endraw %}";
  this.page.identifier = "{% raw %}{{ page.id }}{% endraw %}";
};
{% endhighlight %}

All done here, now Jekyll is ready to show comments for posts where commenting is enabled.

Enabled comments on posts
=========================
Now all you need to do is to go through your post markdown files, and add *"comments: true"* into the post [FrontMatter](https://jekyllrb.com/docs/frontmatter/) configuration headers.

Once done, reload pages, and Disqus commenting will be enabled.
