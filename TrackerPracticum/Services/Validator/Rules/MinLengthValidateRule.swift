//
// Created by Сергей Махленко on 05.07.2023.
//

import Foundation

struct MinLengthValidateRule: ValidatorRuleProtocol {
    private let length: Int

    init(length: Int) {
        self.length = length
    }

    func handle(name: String, _ value: String) throws -> String {
        guard value.count >= length else {
            throw ValidationError(String(format: "The %@ must be at least %d characters.", name, length))
        }

        return value
    }
}
