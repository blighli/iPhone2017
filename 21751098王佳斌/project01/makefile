cal_w: mycal.m main.m
	clang -fno-objc-arc -framework foundation mycal.m main.m -o cal_w

test:
	./cal_w && ./cal_w 1 1994 && ./cal_w 2017

run:
	./cal_w

clean:
	rm cal_w

