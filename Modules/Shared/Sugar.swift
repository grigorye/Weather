//
//  Sugar.swift
//  GEBase
//
//  Created by Grigory Entin on 08/05/2018.
//

func forceCasted<T>(_ x: Any) -> T {
    return x as! T
}

let defaultCellReuseIdentifier = "Cell"

extension Bool {
    mutating func toggle() {
        self = !self
    }
}
