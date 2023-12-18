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


        var points: [String] = []

        for (key, _) in map {
            if key.hasSuffix("A") {
                points.append(key)
            }
        }

        var stepResult: [Int] = []
        for p in points {
            var point = p
            var destination = ""
            var index = 0
            var steps = 0
            while !destination.hasSuffix("Z") {
                if index >= instructions.count {
                    index = 0
                }
                let instruction = instructions[index]
                destination = map[point]![instruction]
                point = destination

                steps += 1
                index += 1
            }
            stepResult.append(steps)
        }

        return lcm(of: stepResult)
    }

    func gcd(_ a: Int, _ b: Int) -> Int {
        if b == 0 { return a }
        return gcd(b, a % b)
    }

    func gcd(of numbers: [Int]) -> Int {
        if numbers.count == 0 {
            return 0
        }

        if numbers.count == 1 {
            return numbers[0]
        }

        var index = 1
        var result = numbers[0]
        while index < numbers.count {
            result = gcd(result, numbers[index])
            index += 1
        }

        return result
    }

    func lcm(_ a: Int, _ b: Int) -> Int {
        a * b / gcd(a, b)
    }

    func lcm(of numbers: [Int]) -> Int {
        if numbers.count == 1 { 
            return numbers[0]
        }

        var index = 1
        var result = numbers[0]
        while index < numbers.count {
            result = lcm(result, numbers[index])
            index += 1
        }
        return result
    }
}

let solver = Solver()
solver.printInput()
print(solver.solve())