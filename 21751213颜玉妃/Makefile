
cal: Day.m PresentYearAndMonth.m PrintYearAndMonth.m main.m
	clang -fno-objc-arc -framework foundation Day.m PresentYearAndMonth.m PrintYearAndMonth.m main.m -o cal

test:
	./cal && ./cal 10 2017 && ./cal 2017

run:
	./cal

clean:
	rm cal