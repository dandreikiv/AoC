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
        let seeds = input[0]
            .components(separatedBy: ":")[1]
            .components(separatedBy: " ")
            .compactMap { Int($0) }
        
        var maps: [String: [[Int]]] = [:]

        var i = 1
        while i < input.count {
            if input[i].contains("map:") { 
                let key = input[i]
                maps[key] = []
                i = i + 1
                while i < input.count && !input[i].isEmpty {
                    let numbers = input[i].components(separatedBy: " ").compactMap { Int($0) }
                    maps[key, default: []] += Array(arrayLiteral: numbers)
                    i = i + 1
                }
            }
            i = i + 1
        } 

        var location = 0
        while true {
            let seed = seedForLocation(location, maps: maps)
            if isSeed(seed, inRanges: seeds) {
                return location
            }
            location += 1
        }
    }

    func isSeed(_ seed: Int, inRanges ranges: [Int]) -> Bool {
        var idx = 0
        while idx < ranges.count {
            let start = ranges[idx]
            let length = ranges[idx + 1]
            
            if seed >= start && seed <= start + length {
                return true
            }
            idx += 2
        }
        return false
    }

   
    func seedForLocation(_ loc: Int, maps: [String: [[Int]]]) -> Int {
        let seedToSoil = maps["seed-to-soil map:", default: []]
        let soilToFertilizer = maps["soil-to-fertilizer map:", default: []]
        let fertilizerToWater = maps["fertilizer-to-water map:", default: []]
        let waterToLight = maps["water-to-light map:", default: []]
        let lightToTemperature = maps["light-to-temperature map:", default: []]
        let temperatureToHumidity = maps["temperature-to-humidity map:", default: []]
        let humidityToLocation = maps["humidity-to-location map:", default: []]

        let humidity = convert(loc, using: humidityToLocation)
        let temperature = convert(humidity, using: temperatureToHumidity)
        let light = convert(temperature, using: lightToTemperature)
        let water = convert(light, using: waterToLight)
        let fertilizer = convert(water, using: fertilizerToWater)
        let soil = convert(fertilizer, using: soilToFertilizer)
        let seed = convert(soil, using: seedToSoil)

        return seed
    }

    func convert(_ input: Int, using ranges: [[Int]]) -> Int {
        for range in ranges {
            let dest = range[0]
            let source = range[1]
            let length = range[2]

            if input >= dest && input < dest + length {
                return input - dest + source
            }
        }
        return input
    }
}

let solver = Solver()
// solver.printInput()
print(solver.solve())