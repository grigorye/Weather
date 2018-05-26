//
//  Assembler.swift
//  WeatherAppKit
//
//  Created by Grigory Entin on 25/05/2018.
//  Copyright © 2018 Grigory Entin. All rights reserved.
//

import Swinject

private var assembler: Assembler!

public let sharedContainer = Container().with {
    assembler = Assembler([ServicesAssembly()], container: $0)
}
