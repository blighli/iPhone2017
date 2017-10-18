CC = clang++
FRAMEWORKS:= -framework Foundation
OBJECTS = main.o calendar.o month.o year.o

cal: $(OBJECTS)
	$(CC) -o cal $(FRAMEWORKS) $(OBJECTS)
main.o: Calendar.h Calendar.m Year.h Year.m
	$(CC) -c main.m
calendar.o: Year.h Year.m Month.h Month.m
	$(CC) -c Calendar.m
month.o: Calendar.h Calendar.m
	$(CC) -c Month.m
year.o: Month.h Month.m
	$(CC) -c Year.m

clean:
	rm cal *.o
