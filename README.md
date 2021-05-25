# request

Function to validate request data for V.

## Summary

- [About](#about)
- [Features](#features)
- [Installation](#installation)
- [Examples](#examples)
- [Available rules](#available-rules)
- [Test](#test)

## About

I created this library to validate request data from my end user form submission for my web apps.

## Features

- Provide a function to validate a `map[string]string` against some rules

## Installation

```v
v install khalyomede.request
```

## Examples

- [1. Process failures](#1-process-failures)
- [2. Use multiple rules for a key](#2-use-multiple-rules-for-a-key)
- [3. Validate a key is required](#3-validate-a-key-is-required)
- [4. Validate a key is filled](#4-validate-a-key-is-filled)
- [5. Validate a key is a boolean](#5-validate-a-key-is-a-boolean)

### 1. Process failures

In this example, we will see a basic usage, and see how to iterate on failures.

```v
import khalyomede.request { Rule, ValidationRule }

fn main() {
  request_data := {
    "name": "John",
  }

  failures := request.validate(request_data, {
    "name": [
      ValidationRule{ rule: Rule.required },
    ]
  })

  for request_key, failed_rules in failures {
    for failed_rule in failed_rules {
      message := match failed_rule.rule {
        .required {
          'The field $request_key is required.'
        }

        .filled {
          'The field $request_key must be filled.'
        }

        .boolean {
          'The field $request_key must be a boolean.'
        }
      }

      println(message)
    }
  }
}
```

### 2. Use multiple rules for a key

In this example, we will see how to validate a key against multiple rules.

```v
import khalyomede.request { Rule, ValidationRule }

fn main() {
  request_data := {
    "name": "John",
  }

  failures := request.validate(request_data, {
    "name": [
      ValidationRule{ rule: Rule.required },
      ValidationRule{ rule: Rule.filled },
    ]
  })

  assert failures.len == 0
}
```

### 3. Validate a key is required

In this example, we will validate that a key is present in the request data.

```v
import khalyomede.request { Rule, ValidationRule }

fn main() {
  request_data := {
    "name": "John",
  }

  failures := request.validate(request_data, {
    "name": [
      ValidationRule{ rule: Rule.required },
    ]
  })

  assert failures.len == 0
}
```

### 4. Validate a key is filled

In this example, we will validate that a key is not empty.

```v
import khalyomede.request

fn main() {
  request_data := {
    "name": "John",
  }

  failures := request.validate(request_data, {
    "name": [
      ValidationRule{ rule: Rule.filled },
    ]
  })

  assert failures.len == 0
}
```


### 5. Validate a key is a boolean

In this example, we will assert a key value is either "0", "1", or "" (suitable for `<input type="checkbox" />` values).

```v
import khalyomede.request

fn main() {
  request_data := {
    "remember_me": "1",
  }

  failures := request.validate(request_data, {
    "name": [
      ValidationRule{ rule: Rule.boolean },
    ]
  })

  assert failures.len == 0
}
```

## Available rules

Check "src/test/validate" folder for a list of available rule as well as code examples.

## Test

```v
v test test/
```
