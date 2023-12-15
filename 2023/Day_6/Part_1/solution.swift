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
        let time = input[0].components(separatedBy: ":")[1].components(separatedBy: " ").compactMap { Int($0) }
        let distance = input[1].components(separatedBy: ":")[1].components(separatedBy: " ").compactMap { Int($0) }

        var winningWays: [Int] = []
        for i in 0..<time.count {
            var count = 0
            for t in 0...time[i] {
                let traveledDistance = totalDistance(waitingTime: t, maxTime: time[i]) 
                if traveledDistance > distance[i] {
                    count += 1
                }
            }
            winningWays.append(count)
        }

        return winningWays.reduce(1, *)
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