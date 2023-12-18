import Foundation
import RegexBuilder

class Solver {

    private var input: [String] = []
    init() {
        loadInput()
    }

    private func loadInput() {
        let url = URL(fileURLWithPath: "../input.txt")
        do {
            input = try String(contentsOf: url).components(separatedBy: "\n")
        } catch {
            print(error)
        }
    }

    func printInput() {
        for line in input {
            print(line)
        }
    }

    func solve() -> Int {
        let hands = input.map {
            let components = $0.components(separatedBy: " ")
            return String(components[0])
        }

        let dict = input.reduce(into: [String: Int]()) { result, next in 
            let components = next.components(separatedBy: " ")
            let hand = components[0]
            let bid = Int(components[1])!
            result[hand] = bid
        }

        let cardStrength: [String: Int] = [
            "A": 100-1, 
            "K": 100-2, 
            "Q": 100-3,
            "J": 100-4,
            "T": 100-5, 
            "9": 100-6,
            "8": 100-7, 
            "7": 100-8, 
            "6": 100-9, 
            "5": 100-10, 
            "4": 100-11, 
            "3": 100-12, 
            "2": 100-13
        ]

        let sortedHands = hands.sorted { hand1, hand2 in
            let hand1Kind = self.handKind(hand1).rawValue
            let hand2Kind = self.handKind(hand2).rawValue

            if hand1Kind == hand2Kind {
                let hand1Chars = hand1.map { String($0) }
                let hand2Chars = hand2.map { String($0) }
                for i in 0..<hand1Chars.count {
                    let strength1 = cardStrength[hand1Chars[i]]!
                    let strength2 = cardStrength[hand2Chars[i]]!
                    if strength1 != strength2 {
                        return strength1 < strength2
                    }
                }
                return false
            } else {
                return hand1Kind < hand2Kind
            }
        }

        var result = 0
        for i in 0..<sortedHands.count {
            let hand = sortedHands[i]
            let bid = dict[hand]!
            result += bid * (i + 1)
        }

        return result
    }

    func handKind(_ hand: String) -> HandKind {
        let dict = hand.map { String($0) }.reduce(into: [String: Int]()) { result, label in
            result[label, default: 0] += 1
        }
        let values = Array(dict.values).sorted()

        switch values {
            case [5]: return .fiveOfKind
            case [1, 4]: return .fourOfKind
            case [2, 3]: return .fullHouse
            case [1, 1, 3]: return .threeOfKind
            case [1, 2, 2]: return .twoPair
            case [1, 1, 1, 2]: return .onePair
            case [1, 1, 1, 1, 1]: return .highCard
            default: return .unknown
        }
    }

    enum HandKind: Int {
        case fiveOfKind = 7
        case fourOfKind = 6
        case fullHouse = 5
        case threeOfKind = 4
        case twoPair = 3
        case onePair = 2
        case highCard = 1
        case unknown = 0
    }
}

let solver = Solver()
solver.printInput()
print(solver.solve())