//
// Created by Сергей Махленко on 04.07.2023.
//

import UIKit

class ValidationError: Error {
    var message: String
    init(_ message: String) {
        self.message = message
    }
}

enum ValidatorRule {
    case required
    case min(length: Int)
    case max(length: Int)
}

enum ValidatorFactory {
    static func validator(for rule: ValidatorRule) -> ValidatorRuleProtocol {
        switch rule {
        case .required: return RequireValidateRule()
        case .min(let length): return MinLengthValidateRule(length: length)
        case .max(let length): return MaxLengthValidateRule(length: length)
        }
    }
}


// MARK: - Helpers validation

extension UITextField {
    func validate(name: String, rule: ValidatorRule) throws -> String {
        let validator = ValidatorFactory.validator(for: rule)

        guard let text = text else { return "" }
        return try validator.handle(name: name, text)
    }
}
