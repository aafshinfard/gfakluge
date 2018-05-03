CXX?=g++
CXXFLAGS:=-O3 -std=c++11 -g -fPIC


BIN_DIR:=bin
BUILD_DIR:=build

LD_LIB_FLAGS=-L./src/ -L./
LD_INC_FLAGS=-I./src/ -I./ -I./$(BUILD_DIR) -I./src/subcommand/

gfak: $(BUILD_DIR)/main.o libgfakluge.a .GFAK_pre-build src/pliib.hpp 
	+$(CXX) $(CXXFLAGS) -o $@ $< $(LD_LIB_FLAGS) $(LD_INC_FLAGS) -lgfakluge

$(BUILD_DIR)/main.o: src/main.cpp .GFAK_pre-build src/gfakluge.hpp src/pliib.hpp
	+$(CXX) $(CXXFLAGS) -c -o $@ $< $(LD_LIB_FLAGS) $(LD_INC_FLAGS) -lgfakluge

libgfakluge.a: $(BUILD_DIR)/gfakluge.o src/pliib.hpp .GFAK_pre-build
	ar -rs $@ $<

$(BUILD_DIR)/gfakluge.o: src/gfakluge.cpp src/gfakluge.hpp .GFAK_pre-build src/pliib.hpp
	$(CXX) $(CXXFLAGS) -c -o $@ $< $(LD_LIB_FLAGS) $(LD_INC_FLAGS)

.PHONY: clean all


.GFAK_pre-build: 
	mkdir -p $(BIN_DIR)
	mkdir -p $(BUILD_DIR)
	touch .GFAK_pre-build
clean:
	$(RM) gfak
	$(RM) src/*.o
	$(RM) *.a
	$(RM) test
	$(RM) x.sort
	$(RM) y.sort
	rm -rf $(BIN_DIR)
	rm -rf $(BUILD_DIR)
	$(RM) .GFAK_pre-build
	$(RM) test_test.gfa
	$(RM) q_test.gfa
