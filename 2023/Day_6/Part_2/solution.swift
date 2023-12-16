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
        let time = Int(input[0]
                .components(separatedBy: ":")[1]
                .replacingOccurrences(of: " ", with: ""))!

        let distance = Int(input[1]
                .components(separatedBy: ":")[1]
                .replacingOccurrences(of: " ", with: ""))!

        var count = 0
        for t in 0...time {
            let traveledDistance = totalDistance(waitingTime: t, maxTime: time) 
            if traveledDistance > distance {
                count += 1
            }
        }

        return count
    }

    func totalDistance(waitingTime: Int, maxTime: Int) -> Int {
        if waitingTime == 0 { return 0 }

        let speed = waitingTime
        let movingTime = (maxTime - waitingTime)

        return movingTime * speed
    }
}

let solver = Solver()
solver.printInput()
print(solver.solve())