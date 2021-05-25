module test

import request { Rule, ValidationRule }

fn test_filled_returns_empty_when_key_is_filled() {
	data := {
		"name": "John",
	}

	actual := request.validate(data, {
		"name": [
			ValidationRule{ rule: Rule.filled },
		],
	})

	assert actual.len == 0
}

fn test_filled_returns_failures_when_key_is_empty() {
	data := {
		"name": "",
	}

	actual := request.validate(data, {
		"name": [
			ValidationRule{ rule: Rule.filled },
		],
	})

	assert actual.len == 1
	assert actual["name"][0].rule == Rule.filled
	assert actual["name"][0].parameters == ""
}

fn test_filled_returns_failures_when_key_only_contains_spaces() {
	data := {
		"name": " ",
	}

	actual := request.validate(data, {
		"name": [
			ValidationRule{ rule: Rule.filled },
		],
	})

	assert actual.len == 1
	assert actual["name"][0].rule == Rule.filled
	assert actual["name"][0].parameters == ""
}

fn test_filled_returns_failures_when_key_not_present() {
	data := map[string]string

	actual := request.validate(data, {
		"name": [
			ValidationRule{ rule: Rule.filled },
		]
	})

	assert actual.len == 1
	assert actual["name"][0].rule == Rule.filled
	assert actual["name"][0].parameters == ""
}
