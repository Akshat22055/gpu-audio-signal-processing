#ifndef SIGNAL_IO_H
#define SIGNAL_IO_H

#include <vector>
#include <string>

std::vector<float> loadSignal(const std::string& filename);
void saveSignal(const std::vector<float>& signal, const std::string& filename);

#endif
