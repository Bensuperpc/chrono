##
## EPITECH PROJECT, 2019
## my_chrono
## File description:
## Makefile
##

CXX			=	g++

CPPFLAGS	=	-W -Wall -Wpedantic -Wextra -Wshadow -Wstrict-overflow=5 -Wmissing-declarations -Wundef		\
				-Wstack-protector -Wno-unused-parameter -Wunreachable-code -march=native -pipe -std=c++17	\
				-Woverloaded-virtual  -Wdisabled-optimization -Winline -Wredundant-decls -Wsign-conversion 	\
				-I $(INCLUDE) 																				\
#-lpthread

BIN			=	my_chrono

BINTEST		=	unit_tests

INCLUDE 	= 	include/									\

SOURCE		=	my_chrono.cpp								\

SRC_MAIN	=	$(addprefix source/,$(SOURCE))				\
				source/main.cpp								\

SRC_TEST	=	$(addprefix source/,$(SOURCE))				\
				tests/test_test.cpp							\
				tests/test_hello_world.cpp					\

OBJ			=	$(SRC_MAIN:%.cpp=%.o)

OBJ_TEST	=	$(SRC_TEST:%.cpp=%.o)

GCDAS		=	$(SRC_MAIN:%.cpp=%.gcda) $(SRC_TEST:%.cpp=%.gcda)
GCNOS		=	$(SRC_MAIN:%.cpp=%.gcno) $(SRC_TEST:%.cpp=%.gcno)

RM			=	rm -f

GCOVR		=	gcovr -r . --exclude tests/

NBR_SRC 	:= 	$(words $(SRC_MAIN))

N 			:= 	i
C 			= 	$(words $N)$(eval N := x $N)
ECHO 		= 	echo -ne "\r \033[92m\e[1m[`expr $C '*' 100 / $(NBR_SRC)`%]\033[0m"

%.o: %.cpp
	@$(ECHO) "Compiling:\e[1m" $@ "\e[22m"
	$(CXX) -c -o $@ $< $(CPPFLAGS)

all: CPPFLAGS += -O3
all: $(BIN)

$(BIN): $(OBJ)
	@echo "\033[1mLinking...\033[0m"
	$(CXX) $(OBJ) -o $(BIN)
	@echo "\033[92mBuild exec: \e[1mOK\033[0m"

tests_run: CPPFLAGS += -O0 -g3 -lcriterion
tests_run: NBR_SRC = $(words $(SRC_TEST))
tests_run: $(BINTEST)
	./$(BINTEST)

$(BINTEST): $(OBJ_TEST)
	@echo "\033[1mLinking...\033[0m"
	$(CXX) $(OBJ_TEST) --coverage -lcriterion -o $(BINTEST)
	@echo "\033[92mBuild: \e[1mOK\033[0m"

coverage_run: CPPFLAGS += --coverage
coverage_run: tests_run
	$(GCOVR)

branches_run: CPPFLAGS += --coverage
branches_run: tests_run
	$(GCOVR) --branches 

coverage_html_run: CPPFLAGS += --coverage
coverage_html_run: tests_run
	$(GCOVR) --html --html-details -o coverage.html 

gdb: CPPFLAGS += -g3 -O0 -ggdb3
gdb:$(BIN)
	gdb ./$(BIN)

valgrind: CPPFLAGS += -g3 -O0 -ggdb3
valgrind:$(BIN)
	valgrind --leak-check=full --track-origins=yes --show-leak-kinds=all -v ./$(BIN)

re:	fclean all

clean:
	$(RM) $(OBJ)
	$(RM) $(OBJ_TEST)
	$(RM) $(GCDAS)
	$(RM) $(GCNOS)
	@echo "\033[0;33mBuilded OBJ: \033[1mcleaned\033[0m"

fclean: clean
	$(RM) $(BIN)
	$(RM) $(BINTEST)
	@echo "\033[0;33mExecutable: \033[1mcleaned\033[0m"

.PHNOY: clean fclean re all tests_run $(BIN) $(BINTEST) coverage_run
