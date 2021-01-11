#!/bin/bash

echo "Clean jekyll cache."
bundle exec jekyll clean

echo "Build with JEKYLL_ENV=production"
JEKYLL_ENV=production bundle exec jekyll build
