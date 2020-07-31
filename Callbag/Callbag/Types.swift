//
//  Types.swift
//  Callbag
//
//  Created by Chu Thin on 7/31/20.
//  Copyright © 2020 Chu Thin. All rights reserved.
//

import Foundation

infix operator +>: AdditionPrecedence
public func +><T>(source: @escaping Source<T>,sink:@escaping Subscribable<T>) -> Dispose{
    return sink(source)
}

public func +><A,B>(source: @escaping Source<A>,transfrom:@escaping Operator<A,B>) -> Source<B>{
    return transfrom(source)
}

public enum Payload<T> {
    case start(Talkback)
    case data(T)
    case end(Any?)
}


public enum SinkPayload<T> {
    case start(Sink<T>)
    case data(T)
    case end(Any?)
    
    func toPayloadWithoutStart() -> Payload<T>? {
        switch self {
        case .data(let value): return .data(value)
        case .end(let value): return .end(value)
        default: return nil
        }
    }
}

extension Payload {
    public func map<U>(_ f: @escaping (T) -> U) -> Payload<U> {
        switch self {
        case .start(let talkback): return .start(talkback)
        case .data(let data): return .data(f(data))
        case .end(let value): return .end(value)
        }
    }
    
    public func flatMap<U>(_ f:(T) -> Payload<U>) -> Payload<U> {
        switch self {
        case .start(let talkback): return .start(talkback)
        case .data(let data): return f(data)
        case .end(let value): return .end(value)
        }
    }
}

public typealias Talkback = (_ payload:Any?) -> Void
public typealias Sink<T> = (_ payload:Payload<T>) -> Void
public typealias Source<T> = (_ sink:@escaping Sink<T>) -> Void;
public typealias Dispose = () -> Void
public typealias Subscribable<T> = (_ source: Source<T>) -> Dispose
public typealias Operator<A, B> = (_ source:@escaping Source<A>) -> Source<B>
public typealias OnEnd = (_ e:Any?) -> Void
public typealias OnData<T> = (T) -> Void
public typealias Subject<T> = (_ payload: SinkPayload<T>) -> Void
