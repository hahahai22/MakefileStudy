# origin版本
# world.out : hello.o main.o
# 	g++ -o world.out hello.o main.o

# hello.o : hello.cpp
# 	g++ -c hello.cpp

# main.o : main.cpp
# 	g++ -c main.cpp

# clean:
# 	rm -f *.o *.out

# 进阶1
# world.out : hello.o main.o # 使用（implicit rule）自动生成hello.o main.o
# 	g++ -o world.out hello.o main.o

# clean:
# 	rm -f *.o *.out

# 进阶2
# OBJS := hello.o main.o
# TARGET := world.out  # 使用变量替换重复出现的值
# $(TARGET) : $(OBJS)
# 	g++ -o $(TARGET) $(OBJS)

# clean:
# 	rm -f $(OBJS) $(TARGET)
# # 变量的定义 变量名 = 值 或者 变量名 := 值 ，变量名为全大写。引用变量使用 $(变量名) 

# 进阶3
# 使用函数
# OBJS := $(patsubst %.cpp,%.o,$(wildcard *.cpp))  # 获取所有的.cpp文件，将.cpp的文件，替换为.o文件。
# TARGET := world.out

# $(TARGET) : $(OBJS)
# 	g++ -o $(TARGET) $(OBJS)

# clean:
# 	rm -f $(OBJS) $(TARGET)

# 进阶4
# # 使用自动变量 $@ $^
# OBJS := $(patsubst %.cpp, %.o, $(wildcard *.cpp))
# TARGET := world.out

# $(TARGET) : $(OBJS)
# 	@echo '$$@ = $@'
# 	g++ -o $(@) $(^)

# clean:
# 	rm -f $(OBJS) $(TARGET)

# 进阶5
# 使用模式匹配规则（pattern rule）
OBJS = $(patsubst %.cpp, %.o, $(wildcard *.cpp))
TARGET = world.out

$(TARGET): $(OBJS)
	g++ -o $(TARGET) $(OBJS)

# 模式匹配规则：当make需要目标 xyz.o 时，自动生成一条 xyz.o: xyz.cpp 规则:
%.o: %.cpp
	@echo 'compiling $<...'
	g++ -c -o $@ $<

.PHONY :clean
clean:
	rm -f *.o $(TARGET)

