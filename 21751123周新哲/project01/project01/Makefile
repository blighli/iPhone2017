DIR_SRC = ./
SRC =

install: Cal.m main.m
            clang -fno-objc-arc -framework foundation Cal.m main.m -o myCal

test:
        ./myCal && ./myCal 2 2016 && ./myCal 2017

run:
        ./myCal

clean:
        rm myCal
