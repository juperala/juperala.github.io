#!/bin/bash

echo "Clean jekyll cache."
bundle exec jekyll clean

echo "Run with JEKYLL_ENV=development"
JEKYLL_ENV=development bundle exec jekyll serve

