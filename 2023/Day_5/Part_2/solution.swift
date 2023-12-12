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

        var idx = 0

        var minLoc = Int.max
        while idx < seeds.count {
            let start = seeds[idx]
            let length = seeds[idx + 1]

            for seed in start...start+length {
                let loc = locationForSeed(seed, maps: maps)
                minLoc = min(minLoc, loc)
            }

            idx += 2
        }

        // print(starts.sorted())

        return minLoc


        return locationForSeed(99, maps: maps)
    }

    func locationForSeed(_ seed: Int, maps: [String: [[Int]]]) -> Int {
        let seedToSoil = maps["seed-to-soil map:", default: []]
        let soilToFertilizer = maps["soil-to-fertilizer map:", default: []]
        let fertilizerToWater = maps["fertilizer-to-water map:", default: []]
        let waterToLight = maps["water-to-light map:", default: []]
        let lightToTemperature = maps["light-to-temperature map:", default: []]
        let temperatureToHumidity = maps["temperature-to-humidity map:", default: []]
        let humidityToLocation = maps["humidity-to-location map:", default: []]

        let soil = convert(seed, using: seedToSoil)
        print("seed: \(seed) to soil: \(soil)")
        let fertilizer = convert(soil, using: soilToFertilizer)
        print("soil: \(soil) to fertilizer: \(fertilizer)")
        let water = convert(fertilizer, using: fertilizerToWater)
        print("fertilizer: \(fertilizer) to water: \(water)")
        let light = convert(water, using: waterToLight)
        print("water: \(water) to light: \(water)")
        let temperature = convert(light, using: lightToTemperature)
        print("light: \(light) to temperature: \(temperature)")
        let humidity = convert(temperature, using: temperatureToHumidity)
        print("temperature: \(temperature) to humidity: \(humidity)")
        let location = convert(humidity, using: humidityToLocation)
        print("humidity: \(humidity) to location: \(location)", location)

        return location
    }

    func convert(_ input: Int, using ranges: [[Int]]) -> Int {
        for range in ranges {
            let dest = range[0]
            let source = range[1]
            let length = range[2]

            if input >= source && input < source + length {
                return dest + input - source
            }
        }
        return input
    }
}

let solver = Solver()
// solver.printInput()
print(solver.solve())