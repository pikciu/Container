import Foundation

public protocol Module {
    static func register(in container: Container)
}
