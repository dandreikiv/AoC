import Foundation

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
        let instructions = input[0].map { $0 == "L" ? 0 : 1 }
        var map: [String: [String]] = [:]
    
        for i in 2..<input.count {
            let components = input[i].components(separatedBy: " = ")
            let point = components[0]

            let directions = components[1]
                                .replacingOccurrences(of: "(", with: "")
                                .replacingOccurrences(of: ")", with: "")
                                .components(separatedBy: ", ")
            map[point] = directions
        }

        var destination = ""
        var index = 0
        var steps = 0
        var point = "AAA"
        while destination != "ZZZ" {
            if index >= instructions.count {
                index = 0
            }
            let instruction = instructions[index]
            destination = map[point]![instruction]
            point = destination

            steps += 1
            index += 1
        }

        return steps
    }
}

let solver = Solver()
solver.printInput()
print(solver.solve())