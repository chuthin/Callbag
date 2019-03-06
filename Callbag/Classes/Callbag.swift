//
//  Callbag.swift
//  Callbag
//
//  Created by chuthin on 6/21/18.
//  Copyright © 2018 chuthin. All rights reserved.
//

import Foundation

public typealias SourceTalkback = (SourcePayload) -> Void
public typealias SinkTalkback<T> = (SinkPayload<T>) -> Void
public typealias Source<T> = (@escaping SinkTalkback<T>) -> Void
public typealias Sink<T> = (Source<T>) -> Void
public typealias Transform<T,O> = (@escaping Source<T>) -> Source<O>

public enum PullState {
    case Pause
    case Resume
    case End
}

public enum SourcePayload {
    case Start
    case Pull(PullState)
    case End
}

public enum SinkPayload<T>{
    case Start(SourceTalkback)
    case Push(T)
    case End
}

public struct Callbag<T> {
    let source:Source<T>
}
