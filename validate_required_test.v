module test

import request { Rule, ValidationRule }

fn test_required_returns_empty_when_field_is_present() {
	data := {
		"name": "John",
	}

	actual := request.validate(data, {
		"name": [
			ValidationRule{ rule: Rule.required },
		]
	})

	assert actual.len == 0
}

fn test_required_returns_empty_when_field_value_is_empty() {
	data := {
		"name": "John",
	}

	actual := request.validate(data, {
		"name": [
			ValidationRule{ rule: Rule.required },
		]
	})

	assert actual.len == 0
}

fn test_required_returns_failed_rule_if_field_not_present() {
	data := map[string]string

	actual := request.validate(data, {
		"name": [
			ValidationRule{ rule: Rule.required },
		]
	})

	assert actual.len == 1
	assert actual["name"][0].rule == Rule.required
	assert actual["name"][0].parameters == ""
}
