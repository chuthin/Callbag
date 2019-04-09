//
//  Callbag.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation

public typealias Callbag<T> = (Payload<T>) -> Void
public typealias Transform<T,O> = (@escaping Callbag<T>) -> Callbag<O>
public typealias Filter<T> = (@escaping Callbag<T>) -> Callbag<T>

public enum Payload<T> {
    case start((Payload<T>) -> Void)
    case data(T)
    case end
}

infix operator ~>: AdditionPrecedence
public func ~><T>(source: Callbag<T>,sink:@escaping Callbag<T>) {
    return source(Payload<T>.start(sink))
}

public func ~><T,O>(source: @escaping Callbag<T>,transfrom:Transform<T,O>) -> Callbag<O> {
    return transfrom(source)
}
