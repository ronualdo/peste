# Peste Project

[![Build Status](https://travis-ci.org/ronualdo/peste.svg?branch=master)](https://travis-ci.org/ronualdo/peste)

This is just a toy project used to practice/study a few different subjects. The first
idea was to build a small telegram bot that allows the user to check on my hometown's
movie theater's session.

To try that in production just type `@OhPesteBot cinema` in a Telegram Client.

## Pre-Requisites

* Docker 19.03.6
* Docker Compsoe 1.23.2

## Running Tests

```
docker-compose mix test
```

## Running Project Locally

To run the project, execute the following command:

```
docker-compose up
```

That will start the phoenix server at port `4444`.
