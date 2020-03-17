import Foundation

public typealias Condition = () -> Bool

public var when: If {
    return If()
}

public func give<Value>(_ value: Value, _ if: If) -> Return<Value> {
    return Return<Value>(value: value, if: `if`)
}

public func give<Value>(_ value: Value) -> Return<Value> {
    return Return<Value>(value: value)
}

public func evaluate<Value>(_ returns: Return<Value>...) -> Value? {
    return returns.first(where: { $0.if.fulfilled() })?.value
}

public func evaluate<Value>(default: Value, _ returns: Return<Value>...) -> Value {
    return returns.first(where: { $0.if.fulfilled() })?.value ?? `default`
}

public class If {
    private var conditions: [Condition] = []

    fileprivate func fulfilled() -> Bool {
        return conditions.reduce(true, { $0 && $1() })
    }
    
    public func condition(_ condition: @escaping Condition) -> If {
        conditions.append(condition)
        return self
    }
}

public class Return<Value> {
    public let `if`: If
    public let value: Value
    
    init(value: Value, `if`: If = If()) {
        self.value = value
        self.`if` = `if`
    }
}
