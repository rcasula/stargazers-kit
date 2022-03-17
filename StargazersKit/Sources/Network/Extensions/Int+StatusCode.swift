//
//  Int+StatusCode.swift
//  StargazersKit
//
//  Created by Roberto Casula on 17/03/22.
//

import Foundation

extension Int {

    var isValidStatusCode: Bool {
        200..<300 ~= self
    }
}
