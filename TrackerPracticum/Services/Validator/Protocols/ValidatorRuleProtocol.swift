//
// Created by Сергей Махленко on 05.07.2023.
//

import Foundation

protocol ValidatorRuleProtocol {
    func handle(name: String, _ value: String) throws -> String
}
