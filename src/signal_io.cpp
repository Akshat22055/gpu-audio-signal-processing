#include "signal_io.h"
#include <fstream>

std::vector<float> loadSignal(const std::string& filename) {
    std::vector<float> signal;
    std::ifstream file(filename);
    float value;
    while (file >> value) {
        signal.push_back(value);
    }
    return signal;
}

void saveSignal(const std::vector<float>& signal, const std::string& filename) {
    std::ofstream file(filename);
    for (float v : signal) {
        file << v << "\n";
    }
}
