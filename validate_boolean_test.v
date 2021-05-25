module test

import request { Rule, ValidationRule }

fn test_boolean_returns_empty_if_value_is_1() {
	data := {
		"remember_me": "1"
	}

	actual := request.validate(data, {
		"remember_me": [
			ValidationRule{ rule: Rule.boolean }
		]
	})

	assert actual.len == 0
}

fn test_boolean_returns_empty_if_value_is_0() {
	data := {
		"remember_me": "0"
	}

	actual := request.validate(data, {
		"remember_me": [
			ValidationRule{ rule: Rule.boolean }
		]
	})

	assert actual.len == 0
}

fn test_boolean_returns_empty_if_value_is_empty() {
	data := {
		"remember_me": ""
	}

	actual := request.validate(data, {
		"remember_me": [
			ValidationRule{ rule: Rule.boolean }
		]
	})

	assert actual.len == 0
}

fn test_boolean_returns_failures_if_value_is_text() {
	data := {
		"remember_me": "yes"
	}

	actual := request.validate(data, {
		"remember_me": [
			ValidationRule{ rule: Rule.boolean }
		]
	})

	assert actual.len == 1
	assert actual["remember_me"][0].rule == Rule.boolean
	assert actual["remember_me"][0].parameters == ""
}
