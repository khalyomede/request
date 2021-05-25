module request

pub fn validate(data map[string]string, parameters map[string][]ValidationRule) map[string][]ValidationRule {
	mut failures := map[string][]ValidationRule{}

	for request_key_name, rules in parameters {
		for rule in rules {
			match rule.rule {
				.required {
					if !(request_key_name in data) {
						failures[request_key_name] << ValidationRule{
							rule: rule.rule,
							parameters: rule.parameters,
						}
					}
				}

				.filled {
					value := data[request_key_name] or { "" }

					if value.trim(" ") == "" {
						failures[request_key_name] << ValidationRule{
							rule: rule.rule,
							parameters: rule.parameters,
						}
					}
				}

				.boolean {
					value := data[request_key_name] or { "" }

					if !(value in ["0", "1", ""]) {
						failures[request_key_name] << ValidationRule{
							rule: rule.rule,
							parameters: rule.parameters,
						}
					}
				}
			}
		}
	}

	return failures
}
