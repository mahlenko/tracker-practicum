//
// Created by Сергей Махленко on 05.07.2023.
//

import Foundation

struct RequireValidateRule: ValidatorRuleProtocol {
    func handle(name: String, _ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError(String(format: "The %@ field is required", name))
        }

        return value
    }
}
